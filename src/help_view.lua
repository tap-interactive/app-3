--- Help View class
--This class prints the help guide image view .
--@classmod Help_view
--@author Li
--

-- Class begins
Help_view = {}

---
-- Constructor/Factory for the help view object 
-- This is the constructor of the help view.
--@return The help view instance
function Help_view:new()
  local view = {}
  setmetatable(view, self)
  self.__index = self
  return view
end

---
--Prints the help guide image of the help view.
function Help_view:print_help_info()
  graphics.show_image("src/data/img/Remote.png",140,0) 
  gfx.update()
end 

return Help_view
