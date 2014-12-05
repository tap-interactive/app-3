---
-- Base controller class
-- @classmod controller
-- @author Simon Hellbe

Controller = {}

---
--Constructor/Factory for the controller object.
--@param object
function Controller:new(object)
  object = object or {}      --makes it possible to create a copy
  setmetatable(object,self)  --add the Controller functions to the instance  
  self.__index = self;       --provides inheritance of keys to the instance
  return object
end

---
--Decides whats happens when a key is used
--Gets the input of the remote from the eventhandeler onKey(key, state), then calls the appriate function.
--@param key What button on the remote that was used
--@param state What state the button has: up, down or repeat
function Controller:on_input(key,state)
end

return Controller