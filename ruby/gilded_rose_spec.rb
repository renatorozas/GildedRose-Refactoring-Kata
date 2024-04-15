require 'rspec'

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe "#update_quality" do
    it "decreases quality by 1 when sell_in is greater than 0" do
      items = [Item.new("foo", 1, 25)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 24
    end

    it "decreases quality twice as fast once sell_in is 0" do
      items = [Item.new("foo", 0, 25)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 23
    end

    it "does not decrease quality under 0" do
      items = [Item.new("foo", 20, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    describe "Aged Brie" do
      it "increases in quality the older it gets" do
        items = [Item.new("Aged Brie", 20, 25)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 26
      end

      it "does not increase quality beyond 50" do
        items = [Item.new("Aged Brie", 20, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end
    end

    describe "Sulfuras, Hand of Ragnaros" do
      it "does not decrease quality" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 80
      end
    end

    describe "Backstage passes to a TAFKAL80ETC concert" do
      describe "when sell_in is <= 10" do
        it "increases quality by 2" do
          items = []
          (6..10).to_a.each do |n|
            items << Item.new("Backstage passes to a TAFKAL80ETC concert", n, 25)
          end
          GildedRose.new(items).update_quality()

          items.each do |item|
            expect(item.quality).to eq 27
          end
        end
      end

      describe "when sell_in is <= 5" do
        it "increases quality by 3" do
          items = []
          (1..5).to_a.each do |n|
            items << Item.new("Backstage passes to a TAFKAL80ETC concert", n, 25)
          end
          GildedRose.new(items).update_quality()

          items.each do |item|
            expect(item.quality).to eq 28
          end
        end
      end

      describe "when sell_in is 0" do
        it "decreases quality to 0" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 25)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
        end
      end
    end
  end
end
