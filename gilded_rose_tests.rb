# frozen_string_literal: true

require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'

class TestGildedRose < Test::Unit::TestCase
  def test_normal_item_before_sell_date
    item        = GildedRose.item('Normal Item', 10, 5)
    gilded_rose = GildedRose.new([item])
    gilded_rose.update_quality
    assert_equal item.name, 'Normal Item'
    assert_equal item.quality, 4
  end

  def test_normal_item_on_sell_date
    item        = GildedRose.item('Normal Item', 0, 4)
    gilded_rose = GildedRose.new([item])
    gilded_rose.update_quality
    assert_equal item.quality, 2
  end

  def test_normal_item_after_sell_date
    item        = GildedRose.item('Normal Item', -7, 45)
    gilded_rose = GildedRose.new([item])
    gilded_rose.update_quality
    assert_equal item.quality, 43
  end

  def test_aged_brie_item_before_sell_date
    item        = GildedRose.item('Aged Brie', 10, 22)
    gilded_rose = GildedRose.new([item])
    gilded_rose.update_quality
    assert_equal item.name, 'Aged Brie'
    assert_equal item.quality, 23
  end

  def test_aged_brie_item_on_sell_date
    item        = GildedRose.item('Aged Brie', 0, 44)
    gilded_rose = GildedRose.new([item])
    gilded_rose.update_quality
    assert_equal item.name, 'Aged Brie'
    assert_equal item.quality, 46
  end

  def test_aged_brie_item_after_sell_date
    item        = GildedRose.item('Aged Brie', -4, 22)
    gilded_rose = GildedRose.new([item])
    gilded_rose.update_quality
    assert_equal item.quality, 24
  end

  def test_sulfuras_item_before_sell_date
    item        = GildedRose.item('Sulfuras, Hand of Ragnaros', 10, 20)
    gilded_rose = GildedRose.new([item])
    gilded_rose.update_quality
    assert_equal item.name, 'Sulfuras, Hand of Ragnaros'
    assert_equal item.quality, 20
  end

  def test_sulfuras_item_on_sell_date
    item        = GildedRose.item('Sulfuras, Hand of Ragnaros', 0, 20)
    gilded_rose = GildedRose.new([item])
    gilded_rose.update_quality
    assert_equal item.name, 'Sulfuras, Hand of Ragnaros'
    assert_equal item.quality, 20
  end

  def test_sulfuras_item_after_sell_date
    item        = GildedRose.item('Sulfuras, Hand of Ragnaros', -5, 20)
    gilded_rose = GildedRose.new([item])
    gilded_rose.update_quality
    assert_equal item.quality, 20
  end

  def test_backstage_item_15_days_before_sell_date
    item        = GildedRose.item('Backstage passes to a TAFKAL80ETC concert', 15,10)
    gilded_rose = GildedRose.new([item])
    gilded_rose.update_quality
    assert_equal item.name, 'Backstage passes to a TAFKAL80ETC concert'
    assert_equal item.quality, 11
  end

  def test_backstage_item_10_days_before_sell_date
    item        = GildedRose.item('Backstage passes to a TAFKAL80ETC concert', 10,44)
    gilded_rose = GildedRose.new([item])
    gilded_rose.update_quality
    assert_equal item.name, 'Backstage passes to a TAFKAL80ETC concert'
    assert_equal item.quality, 46
  end

  def test_backstage_item_5_days_before_sell_date
    item        = GildedRose.item('Backstage passes to a TAFKAL80ETC concert', 5,30)
    gilded_rose = GildedRose.new([item])
    gilded_rose.update_quality
    assert_equal item.name, 'Backstage passes to a TAFKAL80ETC concert'
    assert_equal item.quality, 33
  end

  def test_backstage_item_on_sell_date
    item        = GildedRose.item('Backstage passes to a TAFKAL80ETC concert', 0,20)
    gilded_rose = GildedRose.new([item])
    gilded_rose.update_quality
    assert_equal item.name, 'Backstage passes to a TAFKAL80ETC concert'
    assert_equal item.quality, 0
  end

  def test_backstage_item_after_sell_date
    item        = GildedRose.item('Backstage passes to a TAFKAL80ETC concert', -3,20)
    gilded_rose = GildedRose.new([item])
    gilded_rose.update_quality
    assert_equal item.quality, 0
  end
end
