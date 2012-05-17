require File.dirname(File.expand_path(__FILE__)) + "/../lib/sass-fontimage.rb"

require 'sass'

require File.dirname(File.expand_path(__FILE__)) + "/../lib/sass_fontimage/sass_extensions.rb"

OUT_PATH = Pathname.new(File.dirname(__FILE__)) + "out"

scss = <<EOS
$f : font_for_images("test/fonts/testfont-regular.ttf");

#main {
  background: font_image("\\E006", 16px, #f00,  $f)
}
EOS

engine = Sass::Engine.new(scss, :syntax => :scss)
puts engine.render


