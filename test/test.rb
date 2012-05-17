require File.dirname(File.expand_path(__FILE__)) + "/../lib/sass-fontimage.rb"

FONT_PATH = Pathname.new(File.dirname(__FILE__)) + "fonts/testfont-regular.ttf"
FONT_SIZE = 16
FONT_COLOR = "#000000"
CHAR = "_"

s = SassFontimage::FontImage.new(FONT_PATH)

s.write("\\E006")