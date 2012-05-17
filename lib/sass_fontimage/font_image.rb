class SassFontimage::FontImage
  
  # @param font String Path to a font (one that RMagick can use)
  # @param options Options string
  #
  # @option options size Integer Default font size
  # @option options color String Default color  
  # @option options :write_path The path to write the icon to with write (default = "")
  # @option options :file_prefix Prefix to use for filename (default = icon)
  # @option options :file_type Extension to use when writing file (default = png)
  def initialize(font, options = {})
    @font = font
    
    raise ArgumentError, "Font '#{font}' not found on disk" unless File.exist?(font)
    
    defaults = {
      :size => 16, 
      :color => "#000000",
      :write_path => "",
      :file_prefix => "icon",
      :file_type => "png"
    }
    @options = defaults.update(options)
  end
  
  # Renders a character on a RMagick canvas
  #
  # @see SassFontimage::FontImage#write
  # 
  # @return Magick::Image the image with the charactor drawn.
  def render(char, color = @options[:color], size = @options[:size])
    img = Magick::Image.new(size.to_i, size.to_i) do
      self.background_color = "transparent"
    end

    draw = Magick::Draw.new
    
    puts color.class.inspect
    puts size.inspect
    
    char = convert_to_unicode(char)

    draw.font = @font.to_s
    draw.interline_spacing = 0
    draw.pointsize = size.to_i
    draw.gravity = Magick::CenterGravity
    draw.fill = color
    draw.text_antialias = true

    draw.annotate(img, 0, 0, 0, 0, char)
    
    img
  end
  
  # Writes the character out to a image file. 
  # 
  # The resulting filename has the following format:
  # PREFIX-SIZExSIZE-COLOR-HEXCODEPOINT.FILETYPE
  #
  # Example:
  # icon-16x16-000000-f001.png
  # 
  # 
  # @param char String A one character string, can also be a CSS encoded value (\0000)
  # @param color String An optional color, takes default value otherwise
  # @param size Integer An optional fontsize
  # 
  # @return String The filename written to options[:write_path]
  def write(char, color = @options[:color], size = @options[:size])
    img = self.render(char, color, size)

    filename = []
    filename << @options[:file_prefix]
    filename << "#{size}x#{size}"
    filename << color.gsub(/[^a-z0-9_]/i, "")
    filename << convert_to_unicode(char).codepoints.first.to_s(16)
    
    filename = filename.join("-") + "." + @options[:file_type]
    
    path = Pathname.new(@options[:write_path]) + filename
    
    img.write(path.to_s) do
      self.format = "PNG32"
    end 
    
    filename
  end
  
  protected
  
  # Converts css escape to true unicode char
  # also validates if it's truly only one character
  def convert_to_unicode(char)
    if char =~ /\A\\/
      char = [char[1..-1].to_i(16)].pack("U")
    end
    
    raise ArgumentError, "You can only pass one character" if char.size > 1
    
    char
  end
  
end