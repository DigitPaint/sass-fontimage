require File.dirname(File.expand_path(__FILE__)) + "/../lib/sass-fontimage.rb"

require 'sass'
require 'sass/plugin'

require File.dirname(File.expand_path(__FILE__)) + "/../lib/sass_fontimage/sass_extensions.rb"

OUT_PATH = Pathname.new(File.dirname(__FILE__)) + "out"

scss = <<EOS
$f : font_for_images("test/fonts/testfont-regular.ttf");

#main {
  background: font_image("\\E006", 16px, #f00,  $f)
}
EOS

# engine = Sass::Engine.new(scss, :syntax => :scss)
# puts engine.render

Sass::Plugin.options[:style] = :expanded
Sass::Plugin.options[:template_location] = File.dirname(__FILE__) + "/scss"
Sass::Plugin.options[:css_location] = File.dirname(__FILE__) + "/scss"
Sass::Plugin.options[:custom] ||= {}
Sass::Plugin.options[:custom][:font_image_location] = File.dirname(__FILE__) + "/output"
# Sass::Plugin.options[:custom][:font_image_url] = ""
Sass::Plugin.options[:always_update] = true

# compiler = Sass::Plugin::Compiler.new()

Sass::Plugin.update_stylesheets()


