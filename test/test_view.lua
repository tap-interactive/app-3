test_view = {}
local a_view = require('src.view')

  function test_view:setUp()
    -- Set up and prepare here
  
  end
  
  function test_view:test_view_code_inspected()
    assertEquals(1,1)
  end

  function test_view:test_new()
    local vi = a_view:new()
    view = {}
    assertEquals(vi,view)
  end
  
  function test_view:tearDown()
    -- Clean up here
  end
-- end of test_article_view