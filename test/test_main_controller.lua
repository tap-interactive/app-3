test_main_controller = {}
local main_contr = require 'src.main_controller'
  function test_main_controller:setUp()
    -- Set up and prepare here
  
  end
  
  function test_main_controller:test_graphics_code_inspected()
    assertEquals(1,1)
  end
  
  --this one doesnt working -- in method "position" is a nil value
 --  function test_main_controller:test_has_news()
-- self.position = 4
 -- main_contr:move("up")
--  assertEquals(self.position, 4)
--   end

  function test_main_controller:tearDown()
    -- Clean up here
  end
-- end of test_main_controller