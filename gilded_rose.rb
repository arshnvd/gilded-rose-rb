class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class Normal < Item
  def update_quality
    return unless quality.positive?

    @quality -= 1
    @sell_in -= 1

    return if sell_in.positive?

    @quality -= 1
  end
end

class Conjured < Item
  def update_quality
    return unless quality.positive?

    @quality -= 2
    @sell_in -= 1

    return if sell_in.positive?

    @quality -= 2
  end
end

class Brie < Item
  def update_quality
    return unless quality < 50

    @quality += 1
    @sell_in -= 1

    return if sell_in.positive?

    @quality += 1
  end
end

class Backstage < Item
  def update_quality
    return unless quality < 50

    @quality += 1
    @sell_in -= 1

    return unless sell_in < 11

    @quality += 1

    return unless sell_in < 6

    @quality += 1

    return if sell_in.positive?

    @quality = 0
  end
end

class GildedRose
  LEGENDARY_ITEMS = ['Sulfuras, Hand of Ragnaros'].freeze

  SPECIAL_ITEMS   = {
    'Aged Brie' => ::Brie,
    'Conjured' => ::Conjured,
    'Backstage passes to a TAFKAL80ETC concert' => ::Backstage
  }.freeze

  def self.item(name, sell_in, quality)
    klass = SPECIAL_ITEMS.fetch(name, Normal)

    klass.new(name, sell_in, quality)
  end

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if LEGENDARY_ITEMS.include?(item.name)

      item.update_quality
    end
  end
end