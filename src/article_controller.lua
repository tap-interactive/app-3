---
--Controls the articles.
--This class manage and controls the article_view by retrieving articles and sending it to the main view, communicating with their controllers and managing the navigation of the article view.
--@classmod article_controller

Article_controller = {}

---
-- Constructor/Factory for the article controller object
-- This is the constructor of the article controller with inheritance from the base controller.
--@param arguments Takes in an argument as a table containing the position and feed from the main controller
--@return object
function Article_controller:new(arguments)
  -- Create object
  local controller = Controller:new()
  setmetatable(controller, self)
  self.__index = self
  
  -- Load view and model
  controller.view = Article_view:new()
  controller.news_model = News_model:new()
  controller.news_model:load_xml()
  
  -- Set attributes
  controller.position = arguments["position"]
  controller.feed = arguments["feed"]
  controller.page = arguments["page"]
  controller.nr_of_news = controller.news_model:get_size(controller.feed)
  controller.article = controller:retrieve_article()
  controller:show_article(controller.article)
  -- Return the controller
  return controller
end

---
--Retrieves an article from news_tables.lua
--This function retrieves an article based on the position and the feed. It then calls the function show_article in article_view.lua witch prints the article.
function Article_controller:retrieve_article()
  log.info("Load article: "..self.position.." in feed: "..self.feed)
  local position = 9*(self.page-1)+self.position
  local article = self.news_model:get_article(position,self.feed)
  return article
end

---
--Manage all the printing of an article
--This function takes in an article, prints the article background to the screen and calls the function that prints each element of an article.
--@param article A table containing information about one article
function Article_controller:show_article(article)

  local content = self:get_content(article["link"])
  local ingress = self:get_ingress_from_content(content)
  local article_text = self:get_text_from_content(content,ingress)
  
  self.view:print_background()
  self.view:print_category(article["category"])
  self.view:print_article_text(article_text)
  self.view:print_date(article["pubDate"])
  self.view:print_title(article["title"])
  self.view:print_ingress(ingress)
  self.view:print_image(article["image"])
  self.view:print_ad(article["category"])

  
  gfx.update()

end 

---
--Fetches the content of an article from a file.
--This function takes in the link from an article and fetches the content of the text file corresponding to that link name. 
--@param link A string with the name of the file that the article belongs to.
function Article_controller:get_content(link)
  log.info("print content at:" .. "src/data/articles/" .. link)
  local filename= PATH .. "src/data/articles/" .. link
  local file = io.open(filename, "r")
  io.input(file)
  local  content = io.read("*all")
  io.close(file)
  
  return content

end 

---
-- Finds the text corresponding to the ingress in the content.
-- This function returns the first paragraph from the content. It returns the fisrts section of text before a new line. 
-- @param content All the text that belongs to an article.
-- @return ingress A string matching the first paragraph of the content.
function Article_controller:get_ingress_from_content(content)
  return content:match("[^\r\n]+", 1) 

end 

---
-- Finds the text from the content corresponding to the main article text.
-- This function returns a string that corresponds to the text that is not the ingress, i.e. the first paragraph.
-- @param content All the text that belongs to an article.
-- @param ingress The ingress of an article and the first paragraph of the content.
-- @return text The string that corresponds to the main article text.
function Article_controller:get_text_from_content(content,ingress) 
   -- print the ingress at the right position
  local ingress_size = string.len(ingress)
  local text_size = string.len(content)
  
  return string.sub(content,ingress_size+2, content_size)

end 

---
--Manages rcu input
--The crontroller's main task is to manage incoming events and user input. This is function manages rcu input
function Article_controller:on_input(key, state)

  if key == "ok" then
  --Don't know
  elseif key == "up" then
    self:move(key)
  elseif key == "down" then
    self:move(key)
  elseif key == "left" then
    self:move(key)
  elseif key == "right" then
    self:move(key)
  elseif key == "menu" or key == "back" then
    self:move(key)
  end

end

---
--Controls the navigation in the article view.
--This function takes in a pressed key value and change the article showed based on that key. If key is left it retrieves the next article, if key is right it retrieves the previous article. If menu is pressed the main_controller is loaded.
--@param key The key that is pressed down on the remote
function Article_controller:move(key)

  if key == "left" and self.position ~= 1  then
    self.position = self.position -1
    self.article = self:retrieve_article()
    self:show_article(self.article)
    

  elseif key == "right" and self.position+1 <= self.nr_of_news  then
    self.position = self.position +1
    self.page_number = 1
    self.article = self:retrieve_article()
    self:show_article(self.article)

  elseif key == "menu" then
    load_controller("Main_controller", {position = self.position, feed =  self.feed, page = self.page})
  end


end

return Article_controller
