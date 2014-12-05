--
--  This file contains configuration for the smulator (the LÖVE game engine)
--

function love.conf(t)
    t.window.width = 1280 -- t.screen.width in 0.8.0 and earlier
    t.window.height = 720 -- t.screen.height in 0.8.0 and earlier
    t.window.resizable = true
    t.console=true --attaches a console for print() debugging output
end
