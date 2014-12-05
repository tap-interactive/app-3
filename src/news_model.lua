--- News Model Class
--  Build the main_news_model.
--  Main_news_model for fetching all the news from news_table and creating the news object.
-- @classmod news_model
-- @author Li & Ylva
-- @copyright FeedMe@TAP interactive

-- Main_news_model is used to create a model for fetching all the news and store them
News_model = {}

---
-- Constructor/Factory of the news model for the main_view's news object.
-- @param object Main_news_model object
-- @return object Main_news_model object
function News_model:new(object)
  object = object or {}
  setmetatable(object, self)
  self.__index = self
  
  -- Set attributes
  object.server_url = "http://pumi-1.ida.liu.se/news/"
  
  return object
end

--- Download news XML files from online API
function News_model:download_news()
  local files = {"world.xml","entertainment.xml","sport.xml","technology.xml","economy.xml"}
  for key,file in pairs(files) do
    download.url_to_file(self.server_url.."rss/"..file,PATH .. "src/data/rss/" .. file)
  end
end

--- Download images from online API
function News_model:download_images()
  for key,news in pairs(self.all_news) do
    download.url_to_file(self.server_url.."img/"..news["image"],PATH .. "src/data/img/" .. news["image"])
  end
end


---
--Getter for news feeds.
--This function takes in a feed and returns the news table corresponding to that category.
--@param feed The feed of news that is retrieved.
--@return news table
function News_model:get_news_feed(feed)
  if(feed == "world") then
    return self.world_news

  elseif(feed == "sport") then
    return self.sport_news

  elseif(feed == "economy")  then
    return self.economy_news

  elseif(feed == "tech") then
    return self.tech_news

  elseif(feed == "entertainment") then
    return self.entertainment_news

  else
    return self.all_news
  end

end

---
--Getter for one article.
--This function takes in a position and a feed and fetched the news table corresponding to the feed. It then returns the article at the position.
--@param position The position in the news table where the article wanted i located.
--@param feed The feed that the wanted article belongs to.
--@return a table with all information about one article.
function News_model:get_article(position, feed)
  local news = self:get_news_feed(feed)
  return news[position]

end
---
--Returns the size of a feed
--This function takes in a feed an fetches the news table corresponding to that feed and returns the size of that table.
--@param feed The feed that we want to know the size of.
--@return the number of news in a news table
function News_model:get_size(feed)
  return #self:get_news_feed(feed)
end

---
--Creates a table with all news
--This function adds all the news from the different categories to the allNews table and sorts it based on pubDate.
function News_model:create_all_news()
  self.all_news = {}
  self.all_news = self:append_table(self.all_news,self.sport_news)
  self.all_news = self:append_table(self.all_news,self.world_news)
  self.all_news = self:append_table(self.all_news,self.economy_news)
  self.all_news = self:append_table(self.all_news,self.tech_news)

  -- Sort the table with an anonymous function
  table.sort(self.all_news, function (news1,news2)
    local date1 = self:get_date(news1["pubDate"])
    local date2 = self:get_date(news2["pubDate"])
  
    if (date1 > date2) then
      return true
    end
    return false
  end )

end

---
--Adds a table to another table
--This function takes in two tables as parameters and adds the second table to the end of the first table.
--@param t1 The fist table
--@param t2 The second table
--@return t1
function News_model:append_table(t1,t2)
  for i =1, #t2 do
    t1[(#t1+1)]=t2[i]
  end
  return t1
end

---
--Finds os.time format for an article's pubDate
--This function finds the year, month,day and time in the pubDate string and returns the date on os.time format.
--@param s string corresponding to the news pubDate
--@return date in os.time format.
function News_model:get_date(s)
  local monthToNumber ={Jan =1,Feb =2, Mar=3,Apr=4,May=5,Jun=6,Jul=7,Aug=8,Sep=9,Oct=10,Nov=11,Dec=12}

  local y= string.sub(s,13,16)
  local m= monthToNumber[string.sub(s,9,11)]
  local d= string.sub(s,6,7)
  local h= string.sub(s,18,19)
  local mi=string.sub(s,21,22)
  local se=string.sub(s,24,25)

  return os.time{year=y,month=m,day=d,hour=h,min=mi,sec=se}

end

---
--Creates the news tables
--This function creates all the different feeds by calling the read_xml function for each xml file.
function News_model:load_xml()

  self.world_news = xml_parser.read_xml(PATH.."src/data/rss/world.xml", "world")
  self.sport_news = xml_parser.read_xml(PATH.."src/data/rss/sport.xml", "sport")
  self.economy_news = xml_parser.read_xml(PATH.."src/data/rss/economy.xml","economy")
  self.tech_news = xml_parser.read_xml(PATH.."src/data/rss/technology.xml","tech")
  self.entertainment_news = xml_parser.read_xml(PATH.."src/data/rss/entertainment.xml","entertainment")
  self:create_all_news()

end

return News_model
