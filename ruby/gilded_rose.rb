class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if !should_increase_the_older_it_gets(item)
        if item.quality > 0
          decrease_quality(item)
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      update_sell_in_for(item)
      if sell_by_date_has_passed?(item)
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              decrease_quality(item)
            end
          else
            item.quality = 0
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

  def update_sell_in_for(item)
    item.sell_in = item.sell_in - 1 if can_be_sold(item)
  end

  def should_increase_the_older_it_gets(item)
    item.name == "Aged Brie" or item.name.include?("Backstage passes")
  end

  def decrease_quality(item)
    item.quality = item.quality - 1 if can_be_sold(item)
  end

  def can_be_sold(item)
    item.name != "Sulfuras, Hand of Ragnaros"
  end

  def sell_by_date_has_passed?(item)
    item.sell_in < 0
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
