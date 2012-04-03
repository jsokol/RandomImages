require_relative 'flickr'
require 'RMagick'

module Images

  # FUNCTION: Get images from Flickr
  def getImages
    # Counter for image file names
    counter = 1

    # Pulls 9 random images from Flickr
    Flickr.interesting_images.each do |url|
      # Remove .jpg from string
      image = url.gsub!(".jpg", "_b.jpg")

      # Create file name to save image out to
      jpgName = "./images/" + counter.to_s() + ".jpg"

      # Download and save the image
      writeOut = open(jpgName, "wb")
      writeOut.write(open(image).read)
      writeOut.close

      # Convert the JPG to PNG
      thumb = Magick::Image.read(jpgName).first
      thumb.format = "PNG"
      pngName = "./images/" + counter.to_s() + ".png"
      thumb.write(pngName)

      # Remove the JPG
      FileUtils.rm(jpgName)

      # Increment the counter
      counter+=1
    end
  end

  # FUNCTION: Resize images to modify from the original
  def resizeImages
    # For each of the 9 images
    for counter in (1..9)
      pngName = "./images/" + counter.to_s() + ".png"
      image = Magick::Image.read(pngName).first
      # Make the new image 25% larger
      thumb = image.scale(1.25)
      thumb.write(pngName)
    end
  end

end
