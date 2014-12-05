--- Main controller class
-- Main_controller for managing the main feeds on the main_view.  
-- @classmod main_controller
-- @author Li & Ylva
-- @copyright FeedMe@TAP interactive 

--- Attributes setting 
local Main_controller = {
}

--- 
-- Constructor/Factory for the controller object with
-- inheritance from the base controller.
-- See controller.lua for description of object orientation.
-- @param arguments Arguments needed for new an controller object
-- @return object Main_controller object
function Main_controller:new(arguments)
  -- Create object
  local controller = Controller:new()
  setmetatable(controller, self)
  self.__index = self

  -- Load view 
  controller.view = Main_view:new()
  controller.feed = arguments["feed"]
  controller.position = arguments["position"]
  controller.current_page = arguments["page"]
  controller.category_index = get_feed_index(controller.feed)

  -- Load the model, refresh from news API and get the latest news
  controller.news_model = News_model:new()
  controller.news_model:load_xml()
  controller.news = controller.news_model:get_news_feed(controller.feed)
  controller.left_arrow = controller:has_left_news()
  controller.right_arrow = controller:has_right_news()

  --Display data
  controller.view:load({news = controller.news, position = controller.position, category_index = controller.category_index, page = controller.current_page, right_arrow = controller.right_arrow, left_arrow = controller.left_arrow})


  -- Return the controller
  return controller

end

--- 
-- Control the movement of the highlight navigation on the main_view
-- @param direction The direction inputted from the remote controller 
function Main_controller:move(direction)

  if self:has_news(direction) then
    print(self.position)
    if direction == "down" then

      if self.position < 7  then
        self.position = self.position+3
        
        --To go back to the main navigation from feed navigation.
      elseif self.position == 10 then
        self.position = 1
      end    
    end
    
    if direction == "up" and self.position~=10 then
     
     --Goes from main navigation to feed navigation
      if self.position <= 3 then        
        self.position = 10
        
      else        
        self.position = self.position-3
      end
    end
    if direction == "right" then
      --To navigate in the feed navigation.
      if self.position == 10 then
        self:open_next_feed()
        
      elseif self.position%3 ~= 0   then
        self.position = self.position+1
        
      --To show more news to the right.
      elseif self:has_right_news() then
        if self.position == 3 then
          self.position = 1

        elseif self.position == 6 then
          if self:has_super_right() then
            self.position = 4
          else
            self.position = 1
          end

        elseif self.position == 9 then
          if self:has_super_right() then
            self.position = 7
          else
            self.position = 4
          end

        end

        self.current_page = self.current_page + 1
        self.left_arrow = self:has_left_news()
        self.right_arrow = self:has_right_news()
      end
    end

    if direction == "left" then
    
      --In the feed navigation.
      if self.position == 10 then
        self:open_previous_feed()
      
      elseif (self.position ~= 1 and self.position ~= 4 and self.position ~= 7) then
        self.position = self.position-1
     
      --To show more news to the left
      elseif self:has_left_news() then    
        if self.position == 1 then
          self.position = 3

        elseif self.position == 4 then
          self.position = 6

        elseif self.position == 7 then
          self.position = 9

        end
        self.current_page = self.current_page - 1
        self.left_arrow = self:has_left_news()
        self.right_arrow = self:has_right_news()
        
      end
    end
    
    
    self.view:load({news = self.news, position = self.position, category_index = self.category_index, page = self.current_page, right_arrow = controller.right_arrow, left_arrow = controller.left_arrow})

    log.info("Highlight: position="..self.position)
  end

end

--- 
-- The crontroller's main task is to manage incoming events
-- and user input. This is function manages rcu input.
-- @param key The key input from the RCU
-- @param state 
function Main_controller:on_input(key, state)
  log.info("got input")
  if key == "ok" then
    load_controller("Article_controller",{position = self.position, feed =  self.feed, page = self.current_page})
  elseif key == "down" or key == "up" or key == "right"  or key == "left" then
    self:move(key)
  elseif key == "fast_forward" then
    self:open_next_feed()
  elseif key == "rewind" then
    self:open_previous_feed()
  elseif key == "menu" then
    self:open_main_view()
  elseif key == "info" then
    load_controller("Help_controller",{position = self.position, feed =  self.feed, page = self.current_page})
  elseif tonumber(key) then
    self.position = tonumber(key)
    load_controller("Article_controller",{position = self.position, feed =  self.feed, page = self.current_page})
  end

end

--- 
-- Opens next feed
-- Opens next feed in the of the AVALIABLE_FEEDS table, in GUI it is going to the right
function Main_controller:open_next_feed()
  local index = self.category_index
  if AVALIABLE_FEEDS[index+1] then

    self.feed = AVALIABLE_FEEDS[index+1]
    if self.position ~=10 then
      self.position = 1
    end
    self.current_page = 1
    self.category_index = get_feed_index(self.feed)
    self.news = self.news_model:get_news_feed(self.feed)
    self.left_arrow = self:has_left_news()
    self.right_arrow = self:has_right_news()
    self.view:load({news = self.news, position = self.position, category_index = self.category_index, page = self.current_page, right_arrow = controller.right_arrow, left_arrow = controller.left_arrow})
  end
end

--- 
-- Opens the previous feed
-- Opens the previous feed in the of the AVALIABLE_FEEDS table, in GUI it is going to the left
function Main_controller:open_previous_feed()
  local index = self.category_index
  if AVALIABLE_FEEDS[index-1] then
    self.feed = AVALIABLE_FEEDS[index-1]
    if self.position ~=10 then
      self.position = 1
    end
    self.current_page = 1
    self.category_index = get_feed_index(self.feed)
    self.news = self.news_model:get_news_feed(self.feed)
    self.left_arrow = self:has_left_news()
    self.right_arrow = self:has_right_news()
    self.view:load({news = self.news, position = self.position, category_index = self.category_index, page = self.current_page, right_arrow = controller.right_arrow, left_arrow = controller.left_arrow})
  end
end
---
--Checks if there is more news to the left
--This function checks if it is possible to go left in a news feed by checking is the current page is equal to 1 or not. 
--@return true if the there is more news to the left, else return false. 
function Main_controller:has_left_news()
  if(self.current_page~=1) then
    return true
  else 
    return false
  end
end

---
--Checks if there is more news to the right
--This function checks if it is possible to go right in a news feed by checking is the size of the news table is more than 1 * page number. 
--@return true if the there is more news to the right, else return false. 
function Main_controller:has_right_news()
  if(9*self.current_page<#self.news) then
    return true
  else 
    return false
  end
end

---
--Checks if there is any news down or to the left.
--This function checks if it is posible to navigate down or to the right based on if there are any more news in the feed.
--@param direction The direction of a key press.
--@return false if there is no news to the right or down, else return true.
function Main_controller:has_news(direction)
  
  --If we are navigating between the feeds this function doesn't apply. 
  if self.position == 10 then
    return true
  end
  
  if direction == "down" then    

    local position_check = self.position + 9*(self.current_page-1) +3  
    if self.news[position_check] == nil then
      return false
    end  

  end

  if direction == "right" then    

    local position_check = self.position + 9*(self.current_page-1) +1  
    if self.news[position_check] == nil then
      return false
    end  

  end

  return true
end

---
-- Checks if there is a news to the right on the next page.
--@return false if there is not news on the other page o the right, else return true
function Main_controller:has_super_right()

  local position_check = self.position + 9*(self.current_page-1) +7  
  if self.news[position_check] == nil then 
    return false
  end
  return true

end

---
-- Function for opening the fista page (home)
-- Prints the first page in the main view with the highligt over position 1.
function Main_controller:open_main_view()
  self.position = 1
  self.feed = "allnews"
  self.current_page=1
  
  self.category_index = get_feed_index(self.feed)
  self.news = self.news_model:get_news_feed(self.feed)
  self.left_arrow = self:has_left_news()
  self.right_arrow = self:has_right_news()

  --Display data
  self.view:load({news = self.news, position = self.position, category_index = self.category_index, page = self.current_page, right_arrow = self.right_arrow, left_arrow = self.left_arrow})
end

return Main_controller
