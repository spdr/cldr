=begin
  cldr/resource.rb - resource(raw data) classes

  Copyright (C) 2006 Masao Mutoh

  You may redistribute it and/or modify it under the same
  license terms as Ruby.

  $Id: resource.rb,v 1.1.1.1 2006/03/21 07:14:13 mutoh Exp $
=end

module CLDR
  # An abstract class of Resoureces
  class Resource
    def initialize(locale, fallback, textdomain) #:nodoc:
      script = ""
      [locale.to_general, locale.to_s, locale.language, fallback.to_general].each do |v|
	path = File.join(RESOURCE_DIR, v, "#{textdomain}.rb")
	if FileTest.file?(path)
	  File.open(path){|v| script = v.read}
	  break
	end
      end
      self.class.class_eval(script)
      init_data
    end
  end

  class Core < Resource
    # Create a new CLDR::Core object
    # * locale: the Locale::Object
    # * fallback: the Locale::Object if the locale isn't found.
    #   This value should be existed locale.
    # * Returns: a newly created Locale::Object
    def initialize(locale, fallback)
      super(locale, fallback, "core")
    end
  end

  class Calendar < Resource
    # Create a new CLDR::Calendar object
    # * locale: the Locale::Object
    # * fallback: the Locale::Object if the locale isn't found.
    #   This value should be existed locale.
    # * Returns: a newly created Locale::Object
    def initialize(locale, fallback)
      super(locale, fallback, "calendar")
    end
  end

  class TimeZone < Resource
    # Create a new CLDR::TimeZone object
    # * locale: the Locale::Object
    # * fallback: the Locale::Object if the locale isn't found.
    #   This value should be existed locale.
    # * Returns: a newly created Locale::Object
    def initialize(locale, fallback)
      super(locale, fallback, "timezone")
    end
  end

  class Number < Resource
    # Create a new CLDR::Number object
    # * locale: the Locale::Object
    # * fallback: the Locale::Object if the locale isn't found.
    #   This value should be existed locale.
    # * Returns: a newly created Locale::Object
    def initialize(locale, fallback)
      super(locale, fallback, "number")
    end
  end

  class Currency < Resource
    # Create a new CLDR::Currency object
    # * locale: the Locale::Object
    # * fallback: the Locale::Object if the locale isn't found.
    #   This value should be existed locale.
    # * Returns: a newly created Locale::Object
    def initialize(locale, fallback)
      super(locale, fallback, "currency")
    end
  end
end
