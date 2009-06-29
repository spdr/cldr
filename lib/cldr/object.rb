=begin
  cldr/object.rb - CLDR::Object

  Copyright (C) 2006 Masao Mutoh

  You may redistribute it and/or modify it under the same
  license terms as Ruby.

  $Id: object.rb,v 1.1.1.1 2006/03/21 07:14:13 mutoh Exp $
=end

require 'locale'
require 'cldr/utils'
require 'cldr/resource'

module CLDR
  class Object
    @@data_cache = {}

    attr_reader :core, :calendar, :timezone, :number, :currency
    # Create a new CLDR::Object object. This object creates all of
    # the instances of resource classes.
    # * opts: options
    #    * :locale: the Locale::Object
    #    * :fallback: the alternative Locale::Object when locale is not found.
    # * Returns: a newly created Locale::Object
    def initialize(opts = {})
      locale = opts[:locale] ? opts[:locale] : Locale.get
      fallback = opts[:fallback] ? opts[:fallback] : Locale::Object.new("en")

      data = @@data_cache[locale]
      unless data
	@core = Core.new(locale, fallback)
	@calendar = Calendar.new(locale, fallback)
	@timezone = TimeZone.new(locale, fallback)
	@number = Number.new(locale, fallback)
	@currency = Currency.new(locale, fallback)
	@@data_cache[locale] = [@core, @calendar, @timezone, @number, @currency]
      else
	@core, @calendar, @timezone, @number, @currency = data
      end
    end
  end
end
