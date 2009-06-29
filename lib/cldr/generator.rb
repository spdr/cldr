=begin
  cldr/generator.rb - resource files generator from 
  ldml 1.3 format files.

  Copyright (C) 2006 Masao Mutoh

  You may redistribute it and/or modify it under the same
  license terms as Ruby.

  $Id: generator.rb,v 1.1.1.1 2006/03/21 07:14:13 mutoh Exp $
=end

require 'fileutils'
require 'cldr/version'
require 'cldr/parser.rb'

$KCODE = "U"

module CLDR
  module Generator
    class LocaleData
      include Parser

      attr_reader :alias_source, :locale_name

      TARGET_INFO = [
	# [textdomain, [var, meth, xml path, opts = nil], [variable2, meth, ...], ...]
	[:core, 
	  [:h_languages, :parse, "localeDisplayNames/languages/language"],
	  [:h_territories, :parse, "localeDisplayNames/territories/territory"],
	  [:h_scripts, :parse, "localeDisplayNames/scripts/script"],
	  [:layout_orientation, :attribute_only, "layout/orientation", "characters"],
	  [:layout_inlist_casing, :attribute_only, "layout/inList", "casing"],
	  [:h_character_exemplar_characters, :parse, "characters/exemplarCharacters"],
	  [:character_mapping, :attribute_plural, "characters/mapping", ["registry"]],
	  [:delimiter_quotation_start, :parse, "delimiters/quotationStart"],
	  [:delimiter_quotation_end, :parse, "delimiters/quotationEnd"],
	  [:delimiter_alternate_quotation_start, :parse, "delimiters/alternateQuotationStart"],
	  [:delimiter_alternate_quotation_end, :parse, "delimiters/alternateQuotationEnd"],
	  [:measurement_system, :attribute_only, "measurement/measurementSystem", "type"],
	  [:measurement_papersize_height, :parse, "measurement/paperSize/height"],
	  [:measurement_papersize_width, :parse, "measurement/paperSize/width"],
	  [:h_variants, :parse, "localeDisplayNames/variants/variant"],
	  [:h_keys, :parse, "localeDisplayNames/keys/key"],
	  [:h_types, :parse, "localeDisplayNames/types/type"],
	  [:yesstr, :parse, "posix/messages/yesstr"],
	  [:nostr, :parse, "posix/messages/nostr"],
	  [:yesexpr, :parse, "posix/messages/yesexpr"],
	  [:noexpr, :parse, "posix/messages/noexpr"],
	  [:h_references, :attribute_plural, "references/reference", ["uri"]],
	],
	[:calendar, 
	  [:localized_pattern_characters, :parse, "/ldml/dates/localizedPatternChars"],
	  [:default, :attribute_only, "/ldml/dates/calendars/default", "type"],
	  [:h_months, :parse,
	    "dates/calendars/calendar", "months/monthContext/monthWidth", "month"],
	  [:h_monthformat_defaults, :attribute_only, 
	    "dates/calendars/calendar", "months/monthContext/default", "type"],
	  [:h_days, :parse,
	    "dates/calendars/calendar", "days/dayContext/dayWidth", "day"],
	  [:h_dayformat_defaults, :attribute_only, 
	    "dates/calendars/calendar", "days/dayContext/default", "type"],
	  [:h_week_firstdays, :attribute_only, 
	    "dates/calendars/calendar", "week/firstDay", "day"],
	  [:h_weekend_starts, :attribute_plural, 
	    "dates/calendars/calendar", "week/weekendStart", ["day", "time"]],
	  [:h_weekend_ends, :attribute_plural, 
	    "dates/calendars/calendar", "week/weekendEnd", ["day", "time"]],
	  [:h_mindays, :attribute_only, 
	    "dates/calendars/calendar", "week/minDays", "count"],
	  [:h_am, :parse, "dates/calendars/calendar", "am"],
	  [:h_pm, :parse, "dates/calendars/calendar", "pm"],
	  [:h_era_names, :parse, "dates/calendars/calendar", "eras/eraNames/era"],
	  [:h_era_abbrs, :parse, "dates/calendars/calendar", "eras/eraAbbr/era"],
	  [:h_dateformats, :parse, 
	    "dates/calendars/calendar", "dateFormats/dateFormatLength", "dateFormat/pattern"],
	  [:h_dateformat_defaults, :attribute_only, 
	    "dates/calendars/calendar", "dateFormats/default", "type"],
	  [:h_timeformats, :parse, 
	    "dates/calendars/calendar", "timeFormats/timeFormatLength", "timeFormat/pattern"],
	  [:h_timeformat_defaults, :attribute_only, 
	    "dates/calendars/calendar", "timeFormats/default", "type"],
	  [:h_datetimeformats, :parse, 
	    "dates/calendars/calendar", "dateTimeFormats/dateTimeFormatLength", "dateTimeFormat/pattern"],
	  [:h_fields, :parse, 
	    "dates/calendars/calendar", "fields/field", "displayName"],
	  [:h_field_relatives, :parse, 
	    "dates/calendars/calendar", "fields/field", "relative"],
	],
	[:timezone,
	  [:hourformat, :parse, "dates/timeZoneNames/hourFormat"],
	  [:hoursformat, :parse, "dates/timeZoneNames/hoursFormat"],
	  [:regionformat, :parse, "dates/timeZoneNames/regionFormat"],
	  [:fallbackformat, :parse, "dates/timeZoneNames/fallbackFormat"],
	  [:abbreviationfallback, :attribute_only, "dates/timeZoneNames/abbreviationFallback", "type"],
	  [:preferenceordering, :attribute_only, "dates/timeZoneNames/preferenceOrdering", "type"],
	  [:singlecountries, :attribute_only, "dates/timeZoneNames/singleCountries", "list"],
	  [:h_exemplarcities, :parse, "dates/timeZoneNames/zone", "exemplarCity"],
	  [:h_long_generics, :parse, "dates/timeZoneNames/zone", "long/generic"],
	  [:h_long_standards, :parse, "dates/timeZoneNames/zone", "long/standard"],
	  [:h_long_daylights, :parse, "dates/timeZoneNames/zone", "long/daylight"],
	  [:h_short_generics, :parse, "dates/timeZoneNames/zone", "short/generic"],
	  [:h_short_standards, :parse, "dates/timeZoneNames/zone", "short/standard"],
	  [:h_short_daylights, :parse, "dates/timeZoneNames/zone", "short/daylight"],
	],
	[:number,
	  [:symbol_decimal, :parse, "numbers/symbols/decimal"],
	  [:symbol_group, :parse, "numbers/symbols/group"],
	  [:symbol_list, :parse, "numbers/symbols/list"],
	  [:symbol_percentsign, :parse, "numbers/symbols/percentSign"],
	  [:symbol_nativezerodigit, :parse, "numbers/symbols/nativeZeroDigit"],
	  [:symbol_patterndigit, :parse, "numbers/symbols/patternDigit"],
	  [:symbol_plussign, :parse, "numbers/symbols/plusSign"],
	  [:symbol_minussign, :parse, "numbers/symbols/minusSign"],
	  [:symbol_exponential, :parse, "numbers/symbols/exponential"],
	  [:symbol_permille, :parse, "numbers/symbols/perMille"],
	  [:symbol_infinity, :parse, "numbers/symbols/infinity"],
	  [:symbol_nan, :parse, "numbers/symbols/nan"],
	  [:decimalformat, :parse, "numbers/decimalFormats/decimalFormatLength/decimalFormat/pattern"],
	  [:scientificformat, :parse, "numbers/scientificFormats/scientificFormatLength/scientificFormat/pattern"],
	  [:percentformat, :parse, "numbers/percentFormats/percentFormatLength/percentFormat/pattern"],
        ],
        [:currency,
	  [:format, :parse, "numbers/currencyFormats/currencyFormatLength/currencyFormat/pattern"],
	  [:before_match, :parse, 
	    "numbers/currencyFormats/currencySpacing/beforeCurrency/currencyMatch"],
	  [:before_match_surrounding, :parse, 
	    "numbers/currencyFormats/currencySpacing/beforeCurrency/surroundingMatch"],
	  [:before_insertbetween, :parse,
	    "numbers/currencyFormats/currencySpacing/beforeCurrency/insertBetween"],
	  [:after_match, :parse,
	    "numbers/currencyFormats/currencySpacing/afterCurrency/currencyMatch"],
	  [:after_match_surrounding, :parse, 
	    "numbers/currencyFormats/currencySpacing/afterCurrency/surroundingMatch"],
	  [:after_insertbetween, :parse, 
	    "numbers/currencyFormats/currencySpacing/afterCurrency/insertBetween"],
	  [:h_currencies, :parse, "numbers/currencies/currency", "displayName"],
	  [:h_symbols, :parse, "numbers/currencies/currency", "symbol"],
	]
      ]
      TARGET_INFO.each do |textdomain, *infos|
	infos.each do |var, meth, *path|
	  attr_accessor var
	end
      end

      def supplement_alias(root, xml_dir)
	root.get_elements("//alias").each do |v|
	  parent = v.parent
	  sub_ele = nil
	  if v.attributes["source"] == "locale"
	    sub_ele = parent.get_elements(v.attributes["path"])[0]
	  else
	    if v.attributes["path"] == "//ldml"
	      target_path = v.attributes["path"]
	      parent.elements.each{|old| old.remove}
	    elsif v.attributes["path"].nil?
	      #ti.xml only
	      target_path = parent.dup.xpath
	    else
	      raise "Not supported."
	    end
	    
	    filename = File.join(xml_dir, v.attributes["source"] + ".xml")
	    File.open(filename){|sub|
	      doc = REXML::Document.new(sub)
	      sub_ele = doc.elements[target_path]
	    }
	  end
	  sub_ele.elements.each do |child|
	    parent.add_element(child.dup)
	  end
	  v.remove
	end
      end

      def initialize(xml_file = nil, out_dir = nil)
	TARGET_INFO.each do |textdomain, *infos|
	  infos.each do |var, meth, *path|
	    instance_eval("@#{var} = {}")
	  end
	end

	if xml_file
	  @out_dir = out_dir
	  File.open(xml_file) {|f|
	    @doc = REXML::Document.new(f)
	  }
	  file_ary = xml_file.split(/\\|\//)
	  if file_ary.size > 2
	    @xml_file_name = file_ary[(file_ary.size - 3)..(file_ary.size)].join("/")
	  else
	    @xml_file_name = file_ary[0]
	  end
	  @version =  /dtd\/(.*)\/ldml.dtd/.match(@doc.doctype.to_s).to_a[1]
	  @revision = attribute("/ldml/identity/version", "number").sub(/.Revision: /, "")
	  @generation_date = attribute("/ldml/identity/generation", "date").sub(/.Date: /, "")
	  language_type = attribute("/ldml/identity/language", "type")
	  script_type = attribute("/ldml/identity/script", "type")
	  territory_type = attribute("/ldml/identity/territory", "type")

	  # locale name uses "language"_"TERITORY"_"Script" style
	  @locale_name = language_type
	  @locale_name += "_#{territory_type}" if territory_type
	  @locale_name += "_#{script_type}" if script_type
	  @alias_source = attribute("/ldml/alias", "source")
	  @generator = CLDR::Generator

	  root = @doc.elements['ldml']
	  supplement_alias(root, File.dirname(xml_file))

	  TARGET_INFO.each do |textdomain, *infos|
	    infos.each do |var, meth, *opts|
	      instance_eval("@#{var} = parse(var, meth, root, *opts)")
	    end
	  end
	else
	  @alias_source = nil
	  @locale = nil
	  @out_dir = nil
	end
      end

      def update_real(data_name, other)
	instance_eval %Q[
	  if other.#{data_name}
	      if @#{data_name}
		@#{data_name}.update(other.#{data_name})
	      else
		@#{data_name} = other.#{data_name}.dup
	      end
	  end
        ]
      end

      def update(other)
	TARGET_INFO.each do |textdomain, *infos|
	  infos.each do |var, meth, path|
	    update_real(var, other)
	  end
	end
	self
      end

      def print_header(out)
	out.puts %Q[#
# a language data file for Ruby/CLDR
#
# Generated by: #{@generator}
#
# CLDR version: #{@version}
#
# Original file name: #{@xml_file_name}
# Original file revision: #{@revision}
#
# Copyright (C) 2006 Masao Mutoh
#
# This file is distributed under the same license as the Ruby/CLDR.
#

]
      end

      def print_aline(out, k, v)
	out.puts %Q!    @#{k} = "#{v}"!
      end

      def print_messages(data, out)
	varname = data.to_s
	target = instance_eval("@#{data}")
	if /^h_(.*)/ =~ data.to_s
	  varname = $1
	  out.puts "    @#{varname} = {}"
	end
	if target.size == 0
	  $stderr.puts "check: #{varname}" if $DEBUG
	else
	  entry = {}
	  target.to_a.sort{|a, b| a[0] <=> b[0]}.each do |k, v|
	    if /^h_(.*)\|(.*)/ =~ k
	      key = $2
	      var = $1.split(/\|/)
	      varname = var.shift
	      ivar = varname
	      var.each do |i|
		ivar += "[:#{i.gsub(/-/, '_')}]"
		unless entry[ivar]
		  entry[ivar] = true
		  out.puts "    @#{ivar} = {}"
		end
	      end
	      print_aline(out, "#{ivar}[\"#{key}\"]", v)
	    elsif /^h_(.*)/ =~ k 
  	      varname = $1
	      print_aline(out, "#{$1}[\"default\"]", v)
	    else
 	      raise "error? #{k}" if v == Array
              v = v == ":empty:" ? "" : v
              varname = k
	      print_aline(out, k, v)
	    end
  	  end
	end
	varname
      end

	def print
	  FileUtils.mkdir_p(File.join(@out_dir, @locale_name))
	  TARGET_INFO.each do |textdomain, *infos|
	    out = File.open(File.join(@out_dir, @locale_name, "#{textdomain}.rb"), "w")
	    attrs = []
	    print_header(out)
	    out.puts "  private"
            out.puts "  def init_data"
	    infos.each do |var, meth, path|
	      attrs << print_messages(var, out)
	    end
            out.puts "  end"
	    out.puts
	    out.puts "  public"
	    attrs.each do |v|
	      out.puts "  attr_reader :#{v}"
	    end
	    out.close
	  end
	end
      end
      
      module_function
      def parse(localedata_table, root_path, out_path = "lib/cldr/resource/")
	Dir.glob(File.join(root_path, "common/main/*.xml")).sort.each do |v|
	  puts v
	  locale = File.basename(v, ".xml")
	  localedata_table[locale] = LocaleData.new(v, out_path)
	end
      end

      def analyze(localedata_table)
	# Copy root/parent data to child
	localedata_table.to_a.sort{|a, b| a[0] <=> b[0]}.each do |k, v|
	  puts k
	  unless k == "root"
	    langary = k.split(/_/)
	    lang = nil
	    new_data = LocaleData.new.update(localedata_table["root"])
	    while (langary.size > 0)
	      if lang
		lang << "_" + langary.shift
	      else
		lang = langary.shift
	      end
	      new_data.update(localedata_table[lang]) if localedata_table[lang]
	    end
	    v.update(new_data)
	  end
	end

	# Copy alias_source to data
	localedata_table.each{|key, data|
	  if data.alias_source
	    data.update(localedata_table[data.alias_source])
	  end
	}
      end

      def print(localedata_table)
	localedata_table.to_a.sort{|a, b| a[0] <=> b[0]}.each do |k, v|
	  puts k
	  v.print
	end
      end

      def run(root_path)
	puts "Parsing ..."
	localedata_table = {}
	parse(localedata_table, root_path)
	puts "Analyzing ..."
	analyze(localedata_table)
	puts "Outputting ..."
	print(localedata_table)
      end
    end
  end


  if __FILE__ == $0
    CLDR::Generator::LocaleData.new(ARGV[0]).print
    #  CLDR::Generator.run(ARGV[0])
  end
