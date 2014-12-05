test_gfx = {}

  function test_gfx:setUp()
    -- Set up and prepare here
  end
  
  --just test_demo
  function test_gfx:test_get_memory_use()
    local memor = gfx.get_memory_use()
    assertEquals(memor,0)
  end
  
  function test_gfx:test_get_memory_limit()
    local memor = gfx.get_memory_use()
    assertEquals(memor,0)
  end
  function test_gfx:tearDown()
    -- Clean up here
  end
  
  --end of test_gfx