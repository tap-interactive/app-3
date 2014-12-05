--- Article View class
--This class prints all the graphics of the article view including heading, content, images and advertisement.
--@classmod article_view

-- Class begins
Article_view = {}

---
-- Constructor/Factory for the article view object 
-- This is the constructor of the article view.
--@return The article view instance
function Article_view:new()
  local view = {}
  setmetatable(view, self)
  self.__index = self
  return view
end

---
--Prints the background of the article view.
function Article_view:print_background()
  graphics.show_image("src/data/img/article_background.png", 0, 0) 
end 


---
--Prints the title of the article
--This function prints the title of an article in the article view at the right position with the 'Li' font. 
--@param title A string with the title of the article that is being printed
function Article_view:print_title(title)
  local fonts = font_loader.get_fonts()
  text_printer.print_text_zoom(title, 250, 40, 950, 70, fonts["ubuntumonobold"], "uppercase", 1.4) 
end 

---
--Print the article tag of an article
--This function takes in what category the article belongs to and finds the corresponding image to the category. It the prints it in the article view at the right position.
--@param category A string of what category the article belongs to.
function Article_view:print_category(category)
  log.info("print category: ".."src/data/img/" .. category.. "tag.png")
  local filename = "src/data/img/" .. category.. "tag.png"
  graphics.show_scaled_image(filename, 18, 40, 1.5)

end 

---
--Prints the text of the article (the article text).
--This function print the text of an article  to the article view at the right position with font 'ubuntunmono'. 
--@param text A string with the article text.
function Article_view:print_article_text(article_text)  

    local fonts = font_loader.get_fonts()
    text_printer.print_text(article_text, 80, 190, 760, 460, fonts["anonymousprobold"], "normal") --y = 210 before

end 

---
--Print the ingress of an article
--This function takes in the ingress as a string and prints it in the article view. 
--@param ingress A string with the article ingress.
function Article_view:print_ingress(ingress)
  local fonts = font_loader.get_fonts()
  text_printer.print_text(ingress, 80, 90, 1135, 500, fonts["anonymousprobold"], "normal") 
end 

---
--Prints the date of the article
--This function takes in the date and prints it at the right position with font 'Li'.
--@param date The date of the article as a string
function Article_view:print_date(date)
--print date at the right position

end 

---
--Prints the image of the article
--This function takes in the image name and prints the corresponding image at the right position.
--@param image A string with the file name of the article image. 
function Article_view:print_image(image)
  local filename = "src/data/img/" .. image
  graphics.show_image(filename, 870, 210)

end 

---
--Prints the most appropriate add for the article
--This function takes in the category and prints an add based on that category at the right position.
--@param category A string of what category the article belongs to.
function Article_view:print_ad(category)
  local filename = "src/data/img/" .. category .. "_ad.png"
  graphics.show_image(filename, 870, 460)

end 

return Article_view
