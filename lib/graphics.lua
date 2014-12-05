--- Graphics module
-- @module graphics
graphics = {}

---
--Puts an image on the screen
--Puts an image on the screen by copying it on top of the screen. Puts the whole image at the coordinates x,y on the screen. Needs to
--@param img Path of the image, do not send absolut path and do not send an image file
--@param x The height to print the image, number between 0 and 720
--@param y The width to print the image, number between 0 and 1280
function graphics.show_image(img, x, y)
  local image = gfx.loadpng(img)
  image:premultiply()
  local xi = x
  local yi = y
  
  local temp_src_rec = {
    x = 0, 
    y = 0, 
    w = image:get_width(),
    h = image:get_height()
  }
  local temp_des_rec = {
    x = xi, 
    y = yi, 
    w = image:get_width(),
    h = image:get_height()
  }
  
  screen:copyfrom(image, temp_src_rec, temp_des_rec, true)
  image:destroy()
end

---
--Puts an image on the screen, and scales it 
--Puts an image on the screen by copying it on top of the screen. Puts the whole image at the coordinates x,y on the screen. Scales it then by the factor zoom
--@param img Path of the image, do not send absolut path and do not send an image file
--@param x The height to print the image, number between 0 and 720
--@param y The width to print the image, number between 0 and 1280
--@param zoom The factor to scale the image with
function graphics.show_scaled_image(img, x, y, zoom)
  log.info("Load: "..img.." Graphic use: "..gfx.get_memory_use())
  local image = gfx.loadpng(img)
  image:premultiply()
  local xi = x
  local yi = y
  
  local temp_src_rec = {
    x = 0, 
    y = 0, 
    w = image:get_width(),
    h = image:get_height()
  }
  local temp_des_rec = {
    x = xi, 
    y = yi, 
    w = (image:get_width())*zoom,
    h = (image:get_height())*zoom
  }
  screen:copyfrom(image, temp_src_rec, temp_des_rec, true)
  image:destroy()
end


return graphics