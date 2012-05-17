module SassFontimage::SassExtensions::Functions
  def font_image(char, size, color, font)
    filename = font.generate(char, size, color)
    font_image_url(filename)
  end
  
  # Creates a FontImageGenerator to be stored for later use (in a variable)
  # 
  # @param font_file String path to font
  #
  # @options kwargs :file_prefix
  # @options kwargs :file_type  
  def font_for_images(font_file, kwargs = {})
    SassFontimage::SassExtensions::FontImageGenerator.new(font_file.value, font_image_path, self, kwargs)
  end
  
  protected
  
  def font_image_url(filename)
    url = []
    if options[:custom] && options[:custom][:font_image_url]
      url << options[:custom][:font_image_url]
    end
    url << filename
    
    Sass::Script::String.new("url(#{url.join("/")})")
  end
  
  def font_image_path()
    if options[:custom] && options[:custom][:font_image_location]
      options[:custom][:font_image_location]
    else
      ""
    end
    
  end
end