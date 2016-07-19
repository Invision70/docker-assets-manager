Encoding.default_external = 'utf-8'

require "sprockets/standalone"
require "sprockets/es6"

require "autoprefixer-rails"
require "sass"
require "less"
require "uglifier"

class AutoprefixerProcessor
  def call(input)
    return { data: AutoprefixerRails.process(input[:data]).css }
  end
end

module Sprockets
  module LessProcessor

    VERSION = '2'

    def self.cache_key
      @cache_key ||= "#{name}:${VERSION}".freeze
    end

    def self.call(input)
      data = input[:data]
      parser = Less::Parser.new :paths => [input[:load_path]]

      css = input[:cache].fetch([self.cache_key, data]) do
        [parser.parse(data).to_css]
      end

      return { data: css }
    end
  end

  register_mime_type 'text/less', extensions: ['.less'], charset: :unicode
  register_transformer 'text/less', 'text/css', LessProcessor
end

Sprockets::Standalone::RakeTask.new(:assets) do |task, sprockets|

  task.sources = %w(assets/stylesheets assets/javascripts assets/images assets/fonts)
  # Support: .less, .scss, .es6, js, css, images, fonts
  task.assets = []
  task.sources.each do |dir_name|
	  Dir["#{dir_name}/*"].each do |file_name|
	    next if File.directory? file_name
	    task.assets << File.basename(file_name)
	  end
  end
  
  task.output   = File.expand_path('../output', __FILE__)
  task.compress = false
  task.digest   = true

  sprockets.js_compressor  = :uglifier
  sprockets.css_compressor = :sass

  sprockets.register_preprocessor 'text/css', AutoprefixerProcessor.new
end