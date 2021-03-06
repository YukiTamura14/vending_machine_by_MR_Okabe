# frozen_string_literal: true

# Money is a price pool, and behaves as price value
class Money
  include Comparable

  def initialize(price)
    @price = price
    freeze
  end

  def <=>(other)
    @price <=> other.price
  end

  def ==(other)
    @price == other.price
  end

  def +(other)
    self.class.new(@price + other.price)
  end

  def -(other)
    self.class.new(@price - other.price)
  end

  def to_s
    "#{price} yen"
  end

  protected

  attr_reader :price
end

# Currency represents a coin or a banknote, so has only specific value
class Currency < Money
  TYPES = [1, 5, 10, 50, 100, 500, 1000, 5000, 10_000].freeze

  def initialize(price)
    raise 'Absent currency' unless TYPES.include?(price)

    super(price)
  end
end
