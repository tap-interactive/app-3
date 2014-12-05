--- Emulator Events Module
-- The Events module is an event manager hand handler for keyboard and 
-- system events, emulating Zenterio's LuaEngine behavior.
-- @module events

-- Create LuaEngine screen surface and window_image_data to emulate  gfx.update() behavior
-- gfx_update_pending is set to true when gfx.update() has been called, triggers update on love.draw()
gfx_update_pending = false
log.info("Emulator creating the screen surface")
screen = gfx.new_surface(love.window.getDimensions())
screen.name = "screen"
window_image = love.graphics.newImage(screen.image_data)

--- Loves main load file, called on start. Forwards to LuaEngine API onStart() function
function love.load()
  onStart()
end

--- Loves main update function
-- used to calculate timers
-- @param dt Delta time, the time since last update
function love.update(dt)
--system.update_timers()
end

--- Callback function used to draw the screen on every frame
-- We use a global variable to draw once when gfx.update() has been called
function love.draw()
  if gfx_update_pending then
    window_image = love.graphics.newImage(screen.image_data)
    gfx_update_pending = false
    collectgarbage()
  end
  love.graphics.draw(window_image)
end

love.keyboard.setKeyRepeat(true)

local keyboard_to_remote = {
  n = "ok", 
  up = "up",
  down = "down",
  left = "left",
  right = "right",
  r  = "red",
  g = "green",
  y = "yellow",
  b = "blue" ,
  w = "white",
  i = "info",
  m = "menu",
  capslock = "guide",
  o = "opt",
  h = "help",
  lshift = "star",
  ralt = "multi",
  e = "exit",
  p = "pause",
  t = "toggle_tv_radio",
  c = "record",
  lalt = "play",
  s = "stop",
  f = "fast_forward",
  tab  = "rewind",
  l = "skip_forward",
  u = "skip_reverse",
  z = "jump_to_end",
  a = "jump_to_beginning",
  d = "toggle_pause_play",
  v = "vod",
  backspace = "backspace",
  rshift = "hash",
  y = "back",
  x = "ttx",
  q = "record_list",
  k = "play_list",
  q= "mute"
}
keyboard_to_remote["return"] = "ok"

--- Love key press callback function
function love.keypressed(key, isrepeat)
  value= keyboard_to_remote[key]
  if tonumber(key) then
    value = key
  end
  if value then
    if isrepeat then
      onKey(value, "repeat")
    else
      onKey(value, "down")
    end
  end
end

--- Love key release callback function
function love.keyreleased(key)
  if keyboard_to_remote[key] then
    onKey(keyboard_to_remote[key], "up")
  elseif tonumber(key) then
    onKey(key, "up")
  end
end
