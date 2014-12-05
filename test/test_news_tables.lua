local news_t = require 'lib.news_model'
test_news_tables = {}
local news1
local news2

  function test_news_tables:setUp()
    -- Set up and prepare here
   local feed_news = "sport"
   news1 = 'Thu, 06 Nov 2014 08:16:51 EST'
   news2 = 'Thu, 13 Nov 2014 08:16:51 EST'
  end
  
  --just test_demo
  function test_news_tables:test_demo()
    assertEquals(1,1)
  end
  --get_news
  function test_news_tables:test_get_news(feed_news)
  -- body
  news_t.main()
  local all_news = news_t.get_news(feed_news)
  assertNotNil(all_news)
end

--last_date
function test_news_tables:test_get_date()
  -- body
  local date = news_t.get_date(news1)
  assertEquals(date, 6)
end


    
  function test_news_tables:tearDown()
    -- Clean up here
  end
  
  --end of test_news_tables