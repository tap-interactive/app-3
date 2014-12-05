------------------------------------------------------------------
-------------------- surface data types --------------------------
--------------------------------------------------------------------

--An area (pixmap) in graphics memory. Format is 32-bit RGBA.

-- color
-- A Lua table of the color and alpha components, in range 0-255.
-- Valid forms are
-- Specify R, G, B. Alpha is 255 (opaque): {0, 0, 0}
-- Specify R, G, B, A: {0, 0, 0, 0}

-- Specify components by short name. Omitted components default to
-- 0. At least one component must be specified:
-- {r=0, g=0, b=0, a=0}

-- Specify components by long name. Omitted components default to
-- 0. At least one component must be specified.
-- {red=0, green=0, blue=0, alpha=0}

-- rectangle
-- A Lua table specifying x, y, width and height
-- In some cases, width and height are optional.
-- Negative width or height are not allowed.
-- At the moment, negative x or y are not allowed either.
-- Valid forms are:
-- {x=0, y=0, w=0, h=0}
-- {x=0, y=0, width=0, height=0}
--

Surface = {
  name = "empty surface",
  image_data = nil
}


function Surface:new(object)
  object = object or {}
  setmetatable(object,self)
  self.__index = self
  return object
end

-- Surface:img(path)
-- Loads an image from path
function Surface:img(path)
  log.info("Surface loading image: "..path)
  self.name = path
  self.image_data = love.image.newImageData(path)
end

-- Surface:change_size(x,y)
function Surface:change_size(x, y)
  self.image_data = love.image.newImageData(x, y)
end

-- Surface:clear
-- Fills the surface with a solid color, using hardware acceleration.
-- Surface transparency is replaced by the transparency value of
-- <color>.
-- Default color is {0, 0, 0, 0}, that is black and completely transparent.
-- Default rectangle is the whole surface. Parts outside the rectangle
-- are not affected.
function Surface:clear(color, rectangle)
  local c = {
    r = 0,
    g = 0,
    b = 0,
    a = 0
  }
  if color ~= nil then
    c.r = color.r or 0
    c.g = color.g or 0
    c.b = color.b or 0
    c.a = color.a or 0
  end
  local r = {
    x = 0,
    y = 0,
    width = self.image_data:getWidth(),
    height = self.image_data:getHeight()
  }
  if rectangle ~= nil then
    r.x = rectangle.x or 0
    r.y = rectangle.y or 0
    if r.x + rectangle.width <= r.width then
      r.width = rectangle.width
    end
    if r.y + rectangle.height <= r.height then
      r.height = rectangle.height
    end
  end
  local w = r.x + r.width - 1
  local h = r.y + r.height - 1
  for i=r.x, w do
    for j=r.y, h do
      self.image_data:setPixel(i,j,c.r, c.g, c.b, c.a)
    end
  end
end

-- Surface:fill
-- Blends the surface with a solid color, weighing alpha values
-- (SRCOVER). Uses hardware acceleration.
-- Default rectangle is the whole surface. Parts outside the rectangle
-- are not affected.
function Surface:fill(color, rectangle)
  local c = {
    r = 0,
    g = 0,
    b = 0,
    a = 0
  }
  if color ~= nil then
    c.r = color.r or 0
    c.g = color.g or 0
    c.b = color.b or 0
    c.a = color.a or 0
  end
  local r = {
    x = 0,
    y = 0,
    width = self.image_data:getWidth(),
    height = self.image_data:getHeight()
  }
  if rectangle ~= nil then
    r.x = rectangle.x or 0
    r.y = rectangle.y or 0
    if r.x + rectangle.width <= r.width then
      r.width = rectangle.width
    end
    if r.y + rectangle.height <= r.height then
      r.height = rectangle.height
    end
  end
  local w = r.x + r.width - 1
  local h = r.y + r.height - 1
  for i=r.x, w do
    for j=r.y, h do
      self.image_data:setPixel(i,j,c.r, c.g, c.b, c.a)
    end
  end
end

-- Surface:get()
-- Copy pixels from one surface to another, using hardware
-- acceleration. Parts or all of <src_surface> can be copied.
--
-- Scaling is done if dest_rectangle is of different size than
-- src_rectangle. Areas outside of source or destination surfaces are
-- (will be) clipped.
--
-- If <src_rectangle> is nil, the whole <src_surface> is used.
-- If <dest_rectangle> is nil or omitted, x=0, y=0 are assumed and
-- width and height are taken from <src_rectangle>. If <dest_rectangle>
-- doesn't specify width or height, these values are also taken from
-- <src_rectangle>.

-- If <blend_option> is true, copying is blended using the alpha
-- information in <src_surface>. If false, the alpha channel is
-- replaced by the values in <src_surface>.
-- Default is false.
function Surface:get()
  return self.image_data
end

-- Surface:copyfrom(...)
function Surface:copyfrom(src_surface, src_rect, dest_rect, blend_option)
  
  src_rect = src_rect or {}
  src_rect.x = src_rect.x or 0
  src_rect.y = src_rect.y or 0
  src_rect.w = src_rect.w or self.image_data:getWidth()
  src_rect.h = src_rect.h or self.image_data:getHeight()
  
  dest_rect = dest_rect or {}
  dest_rect.x = dest_rect.x or 0
  dest_rect.y = dest_rect.y or 0
  dest_rect.w = dest_rect.w or src_surface.image_data:getWidth()
  dest_rect.h = dest_rect.h or src_surface.image_data:getHeight()
  
  local scale_x = dest_rect.w / src_rect.w
  local scale_y = dest_rect.h / src_rect.h
  
  -- Use these lines to enable transparency with cost problem 
  local canvas = love.graphics.newCanvas(self.image_data:getDimensions())
  canvas:renderTo(function()
    love.graphics.draw(love.graphics.newImage(self.image_data))
    love.graphics.draw(love.graphics.newImage(src_surface.image_data),dest_rect.x,dest_rect.y, 0, scale_x, scale_y)
  end)
  self.image_data = canvas:getImageData()
  
  -- Use the line below to skip transparency and gain performance
  --self.image_data:paste( src_surface:get(), dest_rect.x, dest_rect.y, src_rect.x, src_rect.y, src_rect.w, src_rect.h)
end

-- Surface:get:width()
-- Returns the pixel width (X axis) of the surface
function Surface:get_width()
  return self.image_data:getWidth()
end

-- Surface:get_height()
-- Returns the pixel height (Y axis) of the surface
function Surface:get_height()
  return self.image_data:getHeight()
end

-- Returns the color value at position <x>, <y>, starting with index (0, 0).
-- Mostly for testing, not optimized for speed
function Surface:get_pixel(x, y)
  r, g, b, a = self.image_data:getPixel( x, y )
  return r, g, b, a
end

-- Surface:set_pixel(..
-- Sets the pixel at position <x>, <y> to <color>.
-- Mostly for testing, not optimized for speed
function Surface:set_pixel(x, y, color)
  self.image_data:setPixel(x, y, color.r, color.g, color.b, color.a)
end

-- Surface:premultiply() - NOT IMPLEMENTED
-- Changes the surface pixel components by multiplying the alpha
-- channel into the color channels. This prepares some images for
-- blending with transparency.
function Surface:premultiply()
-- NOT IMPLEMENTED
end

-- Surface:destroy()
-- Frees the graphics memory used by this surface. The same is
-- eventually done automatically by Lua garbage collection for
-- unreferenced surfaces but doing it by hand guarantees the memory is
-- returned at once.
-- The surface can not be used again after this operation.
function Surface:destroy()
  self.image_data = nil
end

return Surface
