=begin
  cldr/test_generator.rb - test for cldr/generator

  Copyright (C) 2006 Masao Mutoh

  You may redistribute it and/or modify it under the same
  license terms as Ruby.

  $Id: test_generator.rb,v 1.1.1.1 2006/03/21 07:14:13 mutoh Exp $
=end

$:.insert(0, "../lib")
$KCODE = "U"

require 'test/unit'
require 'cldr/generator'

class TestGenerator < Test::Unit::TestCase
  @@table = nil
  def setup
    unless @@table
      @@table = {}
      puts "Preparing tests ..."
      puts "Parsing ..."
      CLDR::Generator.parse(@@table, ".")
      puts "Analyzing ..."
      CLDR::Generator.analyze(@@table)
      puts "---"
      puts "Here we go!" 
      puts "---"
    end

    @ja = @@table["ja"]
    @ja_JP = @@table["ja_JP"]
    @zh = @@table["zh"]
    @zh_Hans_SG = @@table["zh_Hans_SG"]
    @zh_SG = @@table["zh_SG"]
  end

  def test_language_data
    assert_equal("日本語", @ja.h_languages["h_languages|ja"])
    assert_equal("中国語", @ja.h_languages["h_languages|zh"])
  end

  def test_script_data
    assert_equal("アラビア文字", @ja.h_scripts["h_scripts|Arab"])
    assert_equal("ひらがな", @ja.h_scripts["h_scripts|Hira"])
  end

  def test_territory_data
    assert_equal("世界", @ja.h_territories["h_territories|001"])
    assert_equal("日本", @ja.h_territories["h_territories|JP"])
  end

  def test_inheritance
    assert_equal("塞波尼斯-克罗地亚文", @zh.h_languages["h_languages|sh"])
    assert_equal("塞尔维亚克罗地亚文", @zh_Hans_SG.h_languages["h_languages|sh"])
    assert_equal("塞尔维亚克罗地亚文", @zh_SG.h_languages["h_languages|sh"])

    assert_equal("日本語", @ja.h_languages["h_languages|ja"])
    assert_equal("日本語", @ja_JP.h_languages["h_languages|ja"])
  end

  def test_data_info
    assert_equal("ja", @ja.locale_name)
    assert_equal("ja_JP", @ja_JP.locale_name)
    assert_equal("zh", @zh.locale_name)
    assert_equal("zh_SG", @zh_SG.locale_name)
    #Note the territory and script is reversed below
    assert_equal("zh_SG_Hans", @zh_Hans_SG.locale_name)
  end

  def test_draft_proposed
    assert_equal("Lojban語", @ja.h_languages["h_languages|jbo"])
    assert_equal("マレー語", @ja.h_languages["h_languages|ms"])
  end
end
