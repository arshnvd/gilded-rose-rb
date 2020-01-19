class GildedRose
  def initialize(items)
    @items = items
  end

  LEGENDARY_ITEMS = ['Sulfuras, Hand of Ragnaros'].freeze

  NORMAL_ITEM = {
    before: [{ symbol: '-', step: 1 }],
    after: [{ symbol: '-', step: 2 }]
  }.freeze

  SPECIAL_ITEMS = {
    'Aged Brie' => {
      before: [{ symbol: '+', step: 1 }],
      after: [{ symbol: '+', step: 2 }]
    },
    'Conjured' => {
      before: [{ symbol: '-', step: 2 }],
      after: [{ symbol: '-', step: 4 }]
    },
    'Backstage passes to a TAFKAL80ETC concert' => {
      before: [
        { symbol: '+', step: 1 },
        { days: 10, symbol: '+', step: 1 },
        { days: 5, symbol: '+', step: 1 }
      ],
      after: [{ symbol: '-' }]
    }
  }.freeze

  def update_quality()
    @items.each do |item|
      next if LEGENDARY_ITEMS.include?(item.name)

      update_quality_for!(item: item, at: :before) if item.sell_in.positive?
      update_quality_for!(item: item, at: :after) unless item.sell_in.positive?

      item.sell_in -= 1
    end
  end

  def update_quality_for!(item:, at:)
    conditions = SPECIAL_ITEMS.fetch(item.name, NORMAL_ITEM)
    rules      = conditions[at]

    rules.each do |rule|
      step = rule[:step] || item.quality
      days = rule[:days]

      days ||
        (item.quality = item.quality.__send__(rule[:symbol], step))

      days &&
        (item.sell_in <= days) &&
        (item.quality = item.quality.__send__(rule[:symbol], step))
    end
  end
end

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
