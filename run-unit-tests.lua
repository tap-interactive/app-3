
-----------------------------------------------
-- Run this file to run unit tests on App 3
-----------------------------------------------

PATH = ""
LOG_OUTPUT_FILE = false
LOG_OUTPUT_CONSOLE = false

local log = require "lib/log" --needs to exist or it will crash

-----------------------------------------------
------------ Require test framework -----------
-----------------------------------------------

-- luaunit framework & tests
require('test.luaunit')
LuaUnit.verbosity = 2

-- tests for LuaUnit
require('test.test_luaunit')

---------- The emulator functions  -------------
local gfx = require "emulator/gfx"
--local rcu = require "emulator/rcu"
--sys = require "emulator/sysmodule"

-- The usurpated love library
love = require('test.usurp_love')

----------------------------------------
------- Unit tests for src files -------
----------------------------------------

--article_controller
require('src.article_controller')
require('test.test_article_controller')

-- xml_to_table
require('lib.xml_parser')
require('test.test_xml_to_table')

-- article_view
require('src.article_view')
require('test.test_article_view')

--main_controller
require('src.controller')
require('test.test_controller')

-- graphics
require('lib.graphics')
require('test.test_graphics')

--main_controller
require('src.main_controller')
require('test.test_main_controller')

--main_news_model
require('src.news_model')
require('test.test_news_model')

-- main_view
require('src.main_view')
require('test.test_main_view')

-- view
require('src.view')
require('test.test_view')

-- gfx
require('emulator/gfx')
require('test.test_gfx')

------------------------------------------
------ Unit testing of lib files ---------
------------------------------------------

-- download
-- require('lib.download')
-- require('test.test_download')

-- test
-- require('lib.log')
-- require('test.test_log')

-- test
require('lib.text_printer')
require('test.test_text_printer')
------------------------------------------
---------- Run the unit tests ------------
------------------------------------------
os.exit( LuaUnit.run() )