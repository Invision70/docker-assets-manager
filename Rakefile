Encoding.default_external = 'utf-8'

require "sprockets/standalone"

require "autoprefixer-rails"
require "sass"
require "sprockets-less"
require "less"
require "uglifier"

class AutoprefixerProcessor < Sprockets::Processor
  def evaluate(context, locals)
    AutoprefixerRails.process(data).css
  end
end

Sprockets::Standalone::RakeTask.new(:assets) do |task, sprockets|
  task.sources = %w(assets/stylesheets assets/javascripts assets/images assets/fonts)

  task.assets = []
  task.sources.each do |dir_name|
    Dir["#{dir_name}/*"].each do |file_name|
      next if File.directory? file_name
      task.assets << File.expand_path(file_name)
    end
  end
  task.output   = File.expand_path('../output', __FILE__)
  task.compress = false
  task.digest   = true

  sprockets.js_compressor  = :uglifier
  sprockets.css_compressor = :sass

  sprockets.register_postprocessor 'text/css', AutoprefixerProcessor
end