test_article_view = {}
local article_view = require('src.article_view')

  function test_article_view:setUp()
    -- Set up and prepare here
  
  end
  
  function test_article_view:test_graphics_code_inspected()
    assertEquals(1,1)
  end

  function test_article_view:test_new()
    local vi = article_view:new()
    view = {}
    assertEquals(vi,view)
  end
  
  function test_article_view:tearDown()
    -- Clean up here
  end
-- end of test_article_view