--- View
-- Base class for views 
-- @classmod view
-- @author Simon Hellbe

View = { }

---
--Constructor/Factory for the view object.
-- @param object Table with properties set already
-- @return object Return Main_view object.
function View:new()
  local view = {}          --create our instance
  setmetatable(view,self)  --add the view functions to the instance  
  self.__index = self;     --provides inheritance of keys to the instance (static variables)
  return view
end


return View