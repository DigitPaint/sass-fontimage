# The actual sass extension
# 
# It has two configuration parameters that can be passed with the SASS custom
# configuration parameters.
#
# :font_image_location is the base path to write the generated images to
# :font_image_url is the base url for the directory where all font images reside, by default it's relative to the :css_location path of SASS.
module SassFontimage::SassExtensions::Functions
  
  # Actually generate the font image
  #
  # @param [String] char The character to generate
  # @param [Size] size Size in pixels (can be css value like 16px)
  # @param [Color] color Color in hex, rgba
  # @param [String] font Path to font within configuration root
  def font_image(char, size, color, font)
    generator = SassFontimage::SassExtensions::FontImageGenerator.get(font, self)
    image_url = generator.generate(char, size, color)
    
    Sass::Script::String.new("url(#{image_url})")
  end

end