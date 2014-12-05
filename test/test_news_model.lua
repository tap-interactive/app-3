test_news_model = {}
local news_t = require 'src.news_model'

local news1
local news2

  function test_news_model:setUp()
    -- Set up and prepare here
  
   news1 = 'Thu, 06 Nov 2014 08:16:51 EST'
   news2 = 'Thu, 13 Nov 2014 08:16:51 EST'
  end
  
  function test_news_model:test_graphics_code_inspected()
    assertEquals(1,1)
  end
 
 function test_news_model:test_get_news_feed()
  -- body
  local newsF = news_t:get_news_feed("sport")
  assertNil(newsF)
end
 
--last_date
function test_news_model:test_get_date()
  -- body
  local date = news_t:get_date(news2)
  assertEquals(date, 1415863011)
end


  function test_news_model:tearDown()
    -- Clean up here
  end
-- end of test_news_model