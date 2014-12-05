---
--Controls the help view.
--This class manage and controls the help_view and manage comunications with the main_view.
--@classmod Help_controller
--@author Li
--

Help_controller = {}

---
-- Constructor/Factory for the help controller object
-- This is the constructor of the help controller with inheritance from the base controller.
--@param arguments Takes in an argument as a table containing the position and feed from the main controller
--@return object
function Help_controller:new(arguments)
  -- Create object
  local controller = Controller:new()
  setmetatable(controller, self)
  self.__index = self
  
  -- Load view and model
  controller.view = Help_view:new()
  
  -- Set attributes
  controller.position = arguments["position"]
  controller.feed = arguments["feed"]
  controller.page = arguments["page"]

  controller:show_help_info()
  -- Return the controller
  return controller
end

---
--Manage the printing of the help guide image
--@return null
function Help_controller:show_help_info()
  self.view:print_help_info()
end 

---
--Manages rcu input
--The crontroller's main task is to manage incoming events and user input. This is function manages rcu input
function Help_controller:on_input(key, state)
  if key == "ok" or key == "info" or key == "menu" then
    self:move(key)
  end
end

---
--Controls the navigation in the help view.
--This function takes in a pressed key value and change the printing showed based on that key.
--If the key is "ok" or "info" or "menu", it will go back to the main_view
--@param key The key that is pressed down on the remote
function Help_controller:move(key)

  if key == "ok" or key == "info" or key == "menu" then
    load_controller("Main_controller", {position = self.position, feed =  self.feed, page = self.page})
  end
end

return Help_controller
