# frozen_string_literal: true

# Button is a view model generated by item
class Button
  attr_reader :name

  def initialize(name, price, vending_machine)
    @name = name
    @price = price
    @vending_machine = vending_machine
    @blink = vending_machine.payment >= price

    vending_machine.add_observer(self)
  end

  def push
    @vending_machine.push_bottun(@name)
  end

  def update(payment)
    blink_last = @blink

    if payment >= @price
      @blink = true
      puts "💥 #{@name} is available" unless blink_last
    end
  end

  def to_s
    if @blink
      "🔵 #{@name}: #{@price}"
    else
      "⚫️ #{@name}: #{@price}"
    end
  end
end

# ButtnList is contains buttons, just a thin wrapper
class ButtonList
  def initialize
    @bottuns = []
  end

  def append(bottun)
    @bottuns << bottun
  end

  def show
    @bottuns.map(&:to_s).join(', ')
  end

  def push(name)
    @bottuns.find { |b| b.name == name }&.push
  end
end