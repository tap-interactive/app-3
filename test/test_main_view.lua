test_main_view = {}

  function test_main_view:setUp()
    -- Set up and prepare here
  
  end
  
  function test_main_view:test_demo()
    assertEquals(1,1)
  end
  
  function test_main_view:test_highlight_position_if_0_return_nil()
  local x_cord = Main_view:highlight(0)
  assertEquals(x_cord, nil)
   end
   
   

  function test_main_view:tearDown()
    -- Clean up here
  end
-- end of test_main_view