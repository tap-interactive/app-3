
------------------ App3_FeedMe Main.lua ------------------ 
-- This file is used to start the app in the emulator
----------------------------------------------------------
package.path = "src/?.lua;" .. package.path --Search for packages in the src folder

-- Get log module here for logging from the emulator
PATH = ""
log = require("lib.log")

-- Prepare and fetch the emulator
gfx = require("emulator.gfx")
system = require("emulator.system")
require("emulator.events")

-- Run the app
require("app")
