class SassFontimage::SassExtensions::FontImageGenerator < Sass::Script::Literal
  def initialize(font, path, context, kwargs)
    @kwargs = kwargs
    @evaluation_context = context    
    @font, @path = font, path
    
    options = kwargs.update(:write_path => path)
    
    @fontimage = SassFontimage::FontImage.new(font, options)
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
    @fontimage.write(char.value, color, size.to_i)
  end

  def respond_to?(meth)
    super || @evaluation_context.respond_to?(meth)
  end

  def method_missing(meth, *args, &block)
    if @evaluation_context.respond_to?(meth)
      @evaluation_context.send(meth, *args, &block)
    else
      super
    end
  end
end