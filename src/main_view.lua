--- Main_view
-- Prints the graphics of the Main_view
-- Prints the background, news_articles, news_headlines, highlight, category_highlight and category_tag 
-- Prints the border of the specified square and also "press OK" sign 
-- @classmod main_view
-- @author Li & Ylva
-- @copyright FeedMe@TAP interactive 

-- Create meta table with attributes

Main_view = {
}


---
--Constructor/Factory for the view object.
-- @return object Return Main_view object. 
function Main_view:new()
  local view = View:new()
  setmetatable(view, self)
  self.__index = self

  -- Return view
  return view

end

---
--Load the news, highlight and category_highlight.
-- @param news Load the table of all news.  
function Main_view:load(arguments)
  self.news = arguments["news"]
  self.page = arguments["page"]
  graphics.show_image("src/data/img/newprototype.png", 0, 0)
  self:add_thumbnail(self.news)
  self:highlight(arguments["position"])
  self:print_headlines(self.news)
  self:category_highlight(arguments["category_index"], arguments["position"]) 
  if arguments["right_arrow"] then
    self:add_right_arrow()
  end
  if arguments["left_arrow"] then
    self:add_left_arrow()
  end
  gfx.update()
end

---
-- Highlight the article on the Main_view-
-- @param position The position code on the screen based on the 9 square.
-- @return null For testing .
function Main_view:highlight(position)
  local x_cord
  local y_cord

  if position < 1 or position > 9 then
    return
  end

  if position == 1 or position == 4 or position == 7 then
    x_cord =67
  elseif position == 2 or position == 5 or position == 8 then
    x_cord =463
  elseif position == 3 or position == 6 or position == 9 then
    x_cord =858
  else
  end

  if position == 1 or position == 2 or position == 3 then
    y_cord =54
  elseif position == 4 or position == 5 or position == 6 then
    y_cord =270
  elseif position == 7 or position == 8 or position == 9 then
    y_cord =486
  else
  end
      
  graphics.show_image("src/data/img/highlighttemp.png", x_cord, y_cord)  
  
  --return -- only for testing
  return 
end

---
-- Highlight category on the Main_view on the top of the screen. 
-- @param position The position where the category is. 
-- @return null For testing .
function Main_view:category_highlight(position, news_position)
  local x_cord
  local y_cord = 14

  if position < 1 or position > 5 then
    return
  end

  if position == 1 then
    x_cord = 431
  elseif position == 2 then
    x_cord = 528
  elseif position == 3 then
    x_cord = 616
  elseif position == 4 then
    x_cord = 691
  elseif position == 5 then
    x_cord = 777
  else

end
if news_position == 10 then
  graphics.show_image("src/data/img/categoryhighlight.png", x_cord, y_cord)
else
  graphics.show_image("src/data/img/categoryhighlight_thin.png", x_cord, y_cord)
end
  --return -- only for testing
  return 
end

---
-- Print headlines in the specified squares.
-- @param main_view_news The table of all news.
function Main_view:print_headlines(main_view_news)
  -- body
  local fonts = font_loader.get_fonts()
  local headline_positions = {
    {xpos= 82, ypos = 180},
    {xpos= 483, ypos = 180},
    {xpos= 883, ypos = 180},
    {xpos= 82, ypos = 396},
    {xpos= 483, ypos = 396},
    {xpos= 883, ypos = 396}, 
    {xpos= 82, ypos = 612},
    {xpos= 483, ypos = 612},
    {xpos= 883, ypos = 612}
  }


  local nr_of_news = 9*self.page
  if #main_view_news < 9*self.page then
    nr_of_news = #main_view_news
  end
  local start = 1+(9*(self.page-1))
  local pos = 1
  for i = start, nr_of_news do
    text_printer.print_text(main_view_news[i]["title"],headline_positions[pos]['xpos'],headline_positions[pos]['ypos'],300,66,fonts["ubuntumonobold"],"uppercase")
    pos = pos +1
  end

end

---
--Print the border of the specified square, the category tag and also "press OK" sign.
-- @param main_view_news The table of all news. 
function Main_view:add_thumbnail(main_view_news)

  local rectangle_positions = {
    {xpos= 68, ypos = 57},
    {xpos= 464, ypos = 57},
    {xpos= 858, ypos = 57},
    {xpos= 68, ypos = 273},
    {xpos= 464, ypos = 273},
    {xpos= 858, ypos = 273}, 
    {xpos= 68, ypos = 489},
    {xpos= 464, ypos = 489},
    {xpos= 858, ypos = 489}
  }

  local tag_positions = {
    {xpos= 67, ypos = 65},
    {xpos= 463, ypos = 65},
    {xpos= 858, ypos = 65},
    {xpos= 67, ypos = 281},
    {xpos= 463, ypos = 281},
    {xpos= 858, ypos = 281}, 
    {xpos= 67, ypos = 497},
    {xpos= 463, ypos = 497},
    {xpos= 858, ypos = 497}
  }


  local nr_of_news = 9*self.page
  if #main_view_news < 9*self.page then
    nr_of_news = #main_view_news
  end

  local start = 1+(9*(self.page-1))
  local pos = 1
  for i = start, nr_of_news do
   graphics.show_image("src/data/img/" ..main_view_news[i]["image"], rectangle_positions[pos]['xpos']+3, rectangle_positions[pos]['ypos']+3 )
   graphics.show_image("src/data/img/rectangle.png", rectangle_positions[pos]['xpos'], rectangle_positions[pos]['ypos'])
   graphics.show_image("src/data/img/textbox.png", rectangle_positions[pos]['xpos']+3, rectangle_positions[pos]['ypos']+116)
   graphics.show_image("src/data/img/" ..main_view_news[i]["category"] .. "tag.png", tag_positions[pos]['xpos']-3, tag_positions[pos]['ypos'])
   pos = pos +1

  end

end

---
-- Prints the left arrow at the right position
function Main_view:add_left_arrow()
 graphics.show_image("src/data/img/leftarrow.png",12, 320)
end

---
-- Prints the right arrow at the right position
function Main_view:add_right_arrow()
 graphics.show_image("src/data/img/rightarrow.png",1226,320)
end

return Main_view