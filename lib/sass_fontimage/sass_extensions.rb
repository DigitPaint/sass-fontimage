# Stub module
module SassFontimage::SassExtensions; end
       
require_relative "sass_extensions/font_image_generator"
require_relative "sass_extensions/functions"

module Sass::Script::Functions
  include SassFontimage::SassExtensions::Functions
end

# Wierd that this has to be re-included to pick up sub-modules. Ruby bug?
class Sass::Script::Functions::EvaluationContext
  include Sass::Script::Functions
end