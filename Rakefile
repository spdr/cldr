=begin
  Rakefile - some tasks for Ruby/CLDR

  Copyright (C) 2006 Masao Mutoh

  You may redistribute it and/or modify it under the same
  license terms as Ruby.

  $Id: Rakefile,v 1.1.1.1 2006/03/21 07:14:13 mutoh Exp $
=end

$: << "lib"

require 'rubygems'
require 'rake'
require 'rake/packagetask'
require 'rake/gempackagetask'

require 'gettext/utils'
require 'cldr/generator'
require 'cldr/version'

desc "Create localized ruby-files from CLDR"
task :generate do
  CLDR::Generator.run(".")
end

gem_spec = lambda do |s|
    s.name = 'cldr'
    s.version = CLDR::VERSION

    s.summary = 'Ruby/CLDR is a library which provides locale informations'
    s.author = 'Masao Mutoh'
    s.email = 'mutoh at highway.ne.jp'
    s.homepage = 'http://www.yotabanana.com/hiki/ruby-cldr.html'
    # s.rubyforge_project = "gettext"
    files = FileList['**/*'].to_a.select{|v| v !~ /common|dtd|core.zip|pkg|CVS/}
    s.files = files
    #s.require_path = 'lib'
    s.description = <<-EOF
      Ruby/CLDR a library which provides locale informations based on 
      Common Locale Data Repository(CLDR) Project[1].

      [1] http://www.unicode.org/cldr/
    EOF
    s.add_dependency('locale', ['> 2.0.0'])
end

desc "Create gem and tar.gz"
spec = Gem::Specification.new &gem_spec

begin
  require 'jeweler'
  Jeweler::Tasks.new &gem_spec
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end


Rake::PackageTask.new("ruby-cldr", CLDR::VERSION) do |o|
  o.package_files = FileList['**/*'].to_a.select{|v| v !~ /common|dtd|core.zip|pkg|CVS/}
  o.need_tar_gz = true
  o.need_zip = false
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar_gz = false
  p.need_zip = false
end
