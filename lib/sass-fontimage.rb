require "rubygems"
require "bundler/setup"

require 'pathname'
require 'rmagick'

# initialize module namespace
module SassFontimage; end


require_relative "sass_fontimage/font_image"

if defined?(Sass)
  require_relative "sass_fontimage/sass_extensions"
end
