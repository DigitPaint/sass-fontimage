require 'fileutils'

class SassFontimage::SassExtensions::FontImageGenerator < Sass::Script::Literal
  
  class << self
    
    def get(font, env)
      @cache ||= {}      
      
      font = font.value
      
      # Stupid cache mechanism, doesn't normalize paths
      return @cache[env][font] if @cache[env] && @cache[env].respond_to?(:[]) && @cache[env][font]
      
      @cache[env] ||= {}
      @cache[env][font] = self.new(font, env)
      
    end
    
    def find_font(file, env)
      load_paths = env.options[:load_paths].map{|p| Pathname.new(p.to_s) }
          
      # Escape glob patterns
      file.gsub(/[\*\[\]\{\}\?]/) do |char|
        "\\#{char}"
      end    
    
      file = Pathname.new(file)
      
      load_paths.each do |p|
        path = file.absolute? ? file : p + file
        if full_path = Dir[path.to_s].first
          return Pathname.new(full_path)
        end
      end
    
      Pathname.new("")
    end
    
    
  end
  
  def initialize(font, env)
    # @kwargs = kwargs
    @environment = env    
    @font = font
    @path = self.class.find_font(font, env)
    
    fontname = @path.basename.to_s.split(".")[0..-2].join(".")
    write_path = self.font_image_location + fontname
    
    unless write_path.directory?
      FileUtils.mkdir(write_path)
    end
    
    @fontimage = SassFontimage::FontImage.new(@path, { :write_path => write_path })
  end
  
  def to_s(kwargs = self.kwargs)
    ""
  end
  
  def value
    self
  end
  
  # Generate the file if needed
  def generate(char, size, color)
    color = "#" + color.rgb.map{|f| f.to_s(16).rjust(2, "0") }.join()
    path = @fontimage.write(char.value, color, size.to_i)
    font_image_url(path)
  end

  def respond_to?(meth)
    super || @environment.respond_to?(meth)
  end

  def method_missing(meth, *args, &block)
    if @environment.respond_to?(meth)
      @environment.send(meth, *args, &block)
    else
      super
    end
  end
  
  def font_image_url(path)
    
    url = []
    if  @environment.options[:custom] &&  @environment.options[:custom][:font_image_url]
      url <<  @environment.options[:custom][:font_image_url]
      url << path.to_s
      url.join("/").squeeze("/")
    elsif @environment.options[:css_location]
      base = Pathname.new(@environment.options[:css_location])
      path.relative_path_from(base)
    end

    
    
  end
  
  
  def font_image_location
    if @environment.options[:custom] && @environment.options[:custom][:font_image_location]
      dir = Pathname.new(@environment.options[:custom][:font_image_location])
      raise "Directory :font_image_location ('#{dir}') does not seem to be a directory" unless dir.directory?
      dir
    else
      ""
    end
  end
  
  

end