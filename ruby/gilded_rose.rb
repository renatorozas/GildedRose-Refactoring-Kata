class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      update_quality_for(item)
      update_sell_in_for(item)
    end
  end

  private

  def update_quality_for(item)
    number_of_updates = sell_by_date_has_passed?(item) ? 2 : 1

    number_of_updates.times do |_|
      should_increase_the_older_it_gets?(item) ? increase_quality(item) : decrease_quality(item)
    end
  end

  def update_sell_in_for(item)
    item.sell_in = item.sell_in - 1 if can_be_sold?(item)
  end

  def sell_by_date_has_passed?(item)
    item.sell_in <= 0
  end

  def should_increase_the_older_it_gets?(item)
    is_aged_brie?(item) or is_backstage_passes?(item)
  end

  def is_aged_brie?(item)
    item.name == "Aged Brie"
  end

  def is_backstage_passes?(item)
    item.name.include?("Backstage passes")
  end

  def increase_quality(item)
    can_increase_quality = item.quality < 50
    return unless can_increase_quality

    if is_backstage_passes?(item)
      increase_quality_of_backstage_passes(item)
    else
      item.quality = item.quality + 1
    end
  end

  def increase_quality_of_backstage_passes(item)
    return item.quality = 0 if item.sell_in <= 0
    return item.quality = item.quality + 3 if item.sell_in <= 5
    return item.quality = item.quality + 2 if item.sell_in <= 10
  end

  def decrease_quality(item)
    can_decrease_quality = item.quality > 0
    item.quality = item.quality - 1 if can_be_sold?(item) and can_decrease_quality
  end

  def can_be_sold?(item)
    item.name != "Sulfuras, Hand of Ragnaros"
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
