-- Main script for App 3

-- Global configuration constants
if not PATH then
  PATH = "/mnt/4-E066-59D5/"
end

LOG_OUTPUT_FILE = true
LOG_OUTPUT_CONSOLE = true
AVALIABLE_FEEDS = { "sport", "economy", "allnews", "world", "tech"} -- Settings function will later replace this table

package.path = PATH.."?.lua;"..package.path -- Fix require() on the box

-- MODULES 
-- Stored in the lib folder
-- access functions on modules with dot, eg. log.info("my message")
log = require("lib.log")
font_loader = require("lib.font_loader")
graphics = require("lib.graphics")
text_printer = require("lib.text_printer")
xml_parser = require("lib.xml_parser")
download = require("lib.download")

-- CLASSES
-- Stored in the src folder
-- Note the naming convention since these global variables only should be used
-- as factories to create objects. Eg. object = Controller.new()
-- access functions on objects with colon, eg. object:do_something() 
Article_controller = require("src.article_controller")
Article_view = require("src.article_view")
Main_controller = require("src.main_controller")
Controller = require("src.controller")
View = require("src.view")
News_model = require("src.news_model")
Main_view = require("src.main_view")
Help_controller = require("src.help_controller")
Help_view = require("src.help_view")

-- App Variables
controller = nil -- The current controller in the app

---
-- Called on when app starts
-- LuaEngine API function called when the script is started in the environment
function onStart()
  log.info("----------------------------------------------------")
  log.info("onStart() run")
  log.info("Graphic memory current use: "..gfx.get_memory_use().. "(limit: "..gfx.get_memory_limit()..")")
  load_controller("Main_controller",{position = 1, feed =  "allnews", page = 1})
end

---
-- Gets input from remote
-- LuaEngine API function called on input forward rcu input to the controller
--@param key What button on the remote that was used
--@param state What state the button has: up, down or repeat
function onKey(key, state)
  -- We're only interested pressed keys, not released ones
  if state == "down" then --could use =="down" if we don't want repeated inputs
    log.info("RCU keypress: "..key)
    controller:on_input(key, state)
  end
end

---
-- Loads a new controller
-- Used by controllers to switch between controllers
--@param controller_name What controller to open
--@param argument Data that is sent between controllers
function load_controller(controller_name,arguments)
  log.info("--------------------------------New controller--------------------------------")
  log.info("Loading controller: "..controller_name.." with aguments : ")
  for key, value in pairs(arguments) do
    log.info(key..": "..value)
   end
  controller = _G[controller_name]:new(arguments)
end

--- 
-- Get the index nr of a feed
-- Input a feed name and the function returns its indexed numbers
-- @param feed_name The name of the feed
-- @return index The index number of the feed
function get_feed_index(feed_name)
  local index = 1
  while AVALIABLE_FEEDS[index] ~= feed_name do
    index=index+1
    end
  return index 
  end