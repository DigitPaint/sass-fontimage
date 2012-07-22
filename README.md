# Sass-FontImage

A small extension for SASS that generates images for icon fonts. This makes it easy to use an image font with `:before` and `:after` in browser that support and let's you generate the images on the fly for
browser who don't

## Usage

We use sass from our custom build script so we add the Rack plugin ourselves. We currently don't support the default `sass` executable.

Setting up Sass-FontImage with the Rack plugin: 

    # This must be done AFTER you require 'sass/plugin/rack'
    require 'sass-fontimage'
    
    # ... 
    
    # Configure the path where sass-fontimage should write the images
    # the path MUST exist.    
    Sass::Plugin.options[:custom] ||= {}    
    Sass::Plugin.options[:custom][:font_image_location] = "./html/images/fonts"

## Syntax

    background: font_image(CHARACTER, FONTSIZE, COLOR,  RELATIVE_PATH_TO_FONT)

### Example

    background: font_image("\E006", 16px, #f00,  "../fonts/testfont-regular.ttf")

## Copyright & license
Copyright (c) 2012 Flurin Egger, DigitPaint, MIT Style License. (see MIT-LICENSE)