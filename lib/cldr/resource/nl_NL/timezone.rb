#
# a language data file for Ruby/CLDR
#
# Generated by: CLDR::Generator
#
# CLDR version: 1.3
#
# Original file name: common/main/nl_NL.xml
# Original file revision: 1.27 $
#
# Copyright (C) 2006 Masao Mutoh
#
# This file is distributed under the same license as the Ruby/CLDR.
#

  private
  def init_data
    @hourformat = "+HH:mm;-HH:mm"
    @hoursformat = "{0}/{1}"
    @regionformat = "{0}"
    @fallbackformat = "{0} ({1})"
    @abbreviationfallback = "standard"
    @preferenceordering = ""
    @singlecountries = "Africa/Bamako America/Godthab America/Santiago America/Guayaquil     Asia/Shanghai Asia/Tashkent Asia/Kuala_Lumpur     Europe/Madrid Europe/Lisbon Europe/London Pacific/Auckland Pacific/Tahiti"
    @exemplarcities = {}
    @exemplarcities["Africa/Casablanca"] = "Casablanca"
    @exemplarcities["Africa/Timbuktu"] = "Timboektoe"
    @exemplarcities["America/Argentina/ComodRivadavia"] = "Comodora Rivadavia"
    @exemplarcities["America/Argentina/Rio_Gallegos"] = "Río Gallegos"
    @exemplarcities["America/Belem"] = "Belém"
    @exemplarcities["America/Cancun"] = "Cancún"
    @exemplarcities["America/Cordoba"] = "Córdoba"
    @exemplarcities["America/Cuiaba"] = "Cuiabá"
    @exemplarcities["America/Maceio"] = "Maceió"
    @exemplarcities["America/Mazatlan"] = "Mazatlán"
    @exemplarcities["America/Merida"] = "Mérida"
    @exemplarcities["America/Mexico_City"] = "Mexico Stad"
    @exemplarcities["America/Montreal"] = "Montréal"
    @exemplarcities["America/Porto_Velho"] = "Pôrto Velho"
    @exemplarcities["America/Sao_Paulo"] = "São Paulo"
    @exemplarcities["America/St_Johns"] = "St. Johns"
    @exemplarcities["Antarctica/DumontDUrville"] = "Dumont d'Urville"
    @exemplarcities["Antarctica/South_Pole"] = "Zuidpool"
    @exemplarcities["Asia/Jerusalem"] = "Jeruzalem"
    @exemplarcities["Asia/Tashkent"] = "Tasjkent"
    @exemplarcities["Asia/Tokyo"] = "Tokyo"
    @exemplarcities["Asia/Ulaanbaatar"] = "Ulaanbaator"
    @exemplarcities["Atlantic/Azores"] = "Azoren"
    @exemplarcities["Atlantic/Canary"] = "Canarische Eilanden"
    @exemplarcities["Europe/Bucharest"] = "Boekarest"
    @exemplarcities["Europe/Lisbon"] = "Lissabon"
    @exemplarcities["Europe/London"] = "Londen"
    @exemplarcities["Europe/Moscow"] = "Moskou"
    @exemplarcities["Europe/Paris"] = "Parijs"
    @exemplarcities["Pacific/Easter"] = "Paaseiland"
    @long_generics = {}
    @long_standards = {}
    @long_standards["Africa/Casablanca"] = "Greenwich Mean Time"
    @long_standards["America/Anchorage"] = "Alaska-standaardtijd"
    @long_standards["America/Chicago"] = "Central-standaardtijd"
    @long_standards["America/Denver"] = "Mountain-standaardtijd"
    @long_standards["America/Halifax"] = "Atlantic-standaardtijd"
    @long_standards["America/Indianapolis"] = "Eastern-standaardtijd"
    @long_standards["America/Los_Angeles"] = "Pacific-standaardtijd"
    @long_standards["America/New_York"] = "Eastern-standaardtijd"
    @long_standards["America/Phoenix"] = "Mountain-standaardtijd"
    @long_standards["America/St_Johns"] = "Newfoundland-standaardtijd"
    @long_standards["Asia/Jerusalem"] = "Israëlische standaardtijd"
    @long_standards["Asia/Shanghai"] = "Chinese standaardtijd"
    @long_standards["Asia/Tokyo"] = "Japanse standaardtijd"
    @long_standards["Europe/Bucharest"] = "Oost-Europese standaardtijd"
    @long_standards["Europe/Paris"] = "Midden-Europese standaardtijd"
    @long_standards["Pacific/Honolulu"] = "Hawaï-standaardtijd"
    @long_daylights = {}
    @long_daylights["Africa/Casablanca"] = "Greenwich Mean Time"
    @long_daylights["America/Anchorage"] = "Alaska-zomertijd"
    @long_daylights["America/Chicago"] = "Central-zomertijd"
    @long_daylights["America/Denver"] = "Mountain-zomertijd"
    @long_daylights["America/Halifax"] = "Atlantic-zomertijd"
    @long_daylights["America/Indianapolis"] = "Eastern-standaardtijd"
    @long_daylights["America/Los_Angeles"] = "Pacific-zomertijd"
    @long_daylights["America/New_York"] = "Eastern-zomertijd"
    @long_daylights["America/Phoenix"] = "Mountain-standaardtijd"
    @long_daylights["America/St_Johns"] = "Newfoundland-zomertijd"
    @long_daylights["Asia/Jerusalem"] = "Israëlische zomertijd"
    @long_daylights["Asia/Shanghai"] = "Chinese standaardtijd"
    @long_daylights["Asia/Tokyo"] = "Japanse standaardtijd"
    @long_daylights["Europe/Bucharest"] = "Oost-Europese zomertijd"
    @long_daylights["Europe/Paris"] = "Midden-Europese zomertijd"
    @long_daylights["Pacific/Honolulu"] = "Hawaï-standaardtijd"
    @short_generics = {}
    @short_standards = {}
    @short_standards["Africa/Casablanca"] = "GMT"
    @short_standards["America/Anchorage"] = "AST"
    @short_standards["America/Chicago"] = "CST"
    @short_standards["America/Denver"] = "MST"
    @short_standards["America/Halifax"] = "AST"
    @short_standards["America/Indianapolis"] = "EST"
    @short_standards["America/Los_Angeles"] = "PST"
    @short_standards["America/New_York"] = "EST"
    @short_standards["America/Phoenix"] = "MST"
    @short_standards["America/St_Johns"] = "CNT"
    @short_standards["Asia/Jerusalem"] = "IST"
    @short_standards["Asia/Shanghai"] = "CTT"
    @short_standards["Asia/Tokyo"] = "JST"
    @short_standards["Europe/Bucharest"] = "EET"
    @short_standards["Europe/Paris"] = "CET"
    @short_standards["Pacific/Honolulu"] = "HST"
    @short_daylights = {}
    @short_daylights["Africa/Casablanca"] = "GMT"
    @short_daylights["America/Anchorage"] = "ADT"
    @short_daylights["America/Chicago"] = "CDT"
    @short_daylights["America/Denver"] = "MDT"
    @short_daylights["America/Halifax"] = "ADT"
    @short_daylights["America/Indianapolis"] = "EST"
    @short_daylights["America/Los_Angeles"] = "PDT"
    @short_daylights["America/New_York"] = "EDT"
    @short_daylights["America/Phoenix"] = "MST"
    @short_daylights["America/St_Johns"] = "CDT"
    @short_daylights["Asia/Jerusalem"] = "IDT"
    @short_daylights["Asia/Shanghai"] = "CDT"
    @short_daylights["Asia/Tokyo"] = "JST"
    @short_daylights["Europe/Bucharest"] = "EEST"
    @short_daylights["Europe/Paris"] = "CEST"
    @short_daylights["Pacific/Honolulu"] = "HST"
  end

  public
  attr_reader :hourformat
  attr_reader :hoursformat
  attr_reader :regionformat
  attr_reader :fallbackformat
  attr_reader :abbreviationfallback
  attr_reader :preferenceordering
  attr_reader :singlecountries
  attr_reader :exemplarcities
  attr_reader :long_generics
  attr_reader :long_standards
  attr_reader :long_daylights
  attr_reader :short_generics
  attr_reader :short_standards
  attr_reader :short_daylights
