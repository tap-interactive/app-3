--- Text_printer Module
-- Integration of the functions for printing text on the screen
-- used as a help library
-- @module text_printer
-- @author Li
-- @copyright FeedMe@TAP interactive

text_printer = {}

chr_table = {}

--- [[ Initialize the text coordinator and line. text_xi is the print cursor's x-coordinate and
-- text_yi is the print cursor's y-coordinate in the surface where the text is printed. Upper
-- left corner of the print surface corresponds to (0,0)
-- ]]
local text_xi = 0
local text_yi = 0
local line_len = 0

--- [[ Get character's single image
--@param chr (the ASCII code of the character wanted) [Integer]
--@param letter_width (the character's width) [Integer]
--]]
-- <<TESTED AND WORKING ON THE STB>>
function get_chr_img(chr,letter_width)
  -- body
  for i=1, #chr_table do
    if chr == chr_table[i].id then
      -- Change later, remove if-elseif-statement and replace with fill_surface and text_xi
      fill_surface(chr_table[i].img, text_xi, text_yi)
      text_xi = text_xi + letter_width
    end
  end
end

--- Calculate the height of the new surface
-- <<TESTED AND WORKING ON THE STB>>
--@param x (The x-position of the surface's upper left corner) [Integer]
--@param y (The y-position of the surface's upper left corner) [Integer]
--@param max_width (The maximum width the surface is allowed to occupy) [Integer]
--@param max_height (The maximum height the surface is allowed to occupy,if the text is too long it ends with "...") [Integer]
--@param letter_width (the width of the letter) [Integer]
--@param letter_height (the height of the letter) [Integer]
--@return temp_surface_height The height of the surface
function cal_surface_height(max_width,max_height,letter_width,letter_height,x,y)
  -- body
  local temp_surface_height = 0
  local cal_height = 0
  -- calculate and set the surface height
  if (max_height > (screen:get_height() - y)) then
    temp_surface_height =screen:get_height() - y
  else
    cal_height = (math.floor(((string.len(text) * letter_width) / max_width)) + 1) * letter_height
    if(max_height > cal_height) then
      temp_surface_height = cal_height
    else
      temp_surface_height = max_height
    end
  end
  return temp_surface_height
end

--- Calculate the width of the new surface
--@param max_width The maximum width the surface is allowed to occupy [Integer]
--@return max_width The width of the surface
function cal_surface_width(max_width)
  return max_width
end

--- Initialize the screen destination coordinates
-- <<TESTED AND WORKING ON STB>>
--@param x (The x-position of the screen's upper left corner) [Integer]
--@param y (The y-position of the screen's upper left corner) [Integer]
--@return text_surface_des_rec The destination position of the text_surface on the screen
--
function text_surface_pos_on_des(x, y)
  -- body
  -- initialize the cordinator that the text surface on the screen
  local text_surface_des_rec = {
    x = x,
    y = y,
    w = text_surface:get_width(),
    h = text_surface:get_height()
  }
  return text_surface_des_rec
end

--- Initialize the new surface source cordinator of the upper left corner
-- <<TESTED AND WORKING ON THE STB>>
--@param x (The x-position of the surface's upper left corner) [Integer]
--@param y (The y-position of the surface's upper left corner) [Integer]
--@return letter_src_rec
function letter_crop_from_src(x, y)
  -- body
  -- initialize the cordinator that the crop of text surface
  local letter_src_rec = {
    x = x,
    y = y,
    w = text_surface:get_width(),
    h = text_surface:get_height()
  }
  return letter_src_rec
end

--- Initialize the new surface
-- <<TESTED AND WORKING ON THE STB>>
--@param surface_width (the width of the surface you want to create) [Integer]
--@param surface_height (the height of the surface you want to create) [Integer]
--
function surface_initialize(surface_width,surface_height)
  -- body
  -- new surface for text by flexible surface width and height
  text_surface = gfx.new_surface(surface_width, surface_height)
  -- Alan's tips below: "When you add a new surface:clear it!"
  text_surface:clear()
end

--- Patch up the character img on surface.
-- <<TESTED AND WORKING ON THE BOX>>
--@param img (each character's img) [img]
--@param x (the x-position of the surface's left corner) [Integer]
--@param y (the y-position of the surface's left corner) [Integer]
function fill_surface(img, x, y)
  -- body
  local xi = x
  local yi = y
  local temp_src_rec = {
    x = 0,
    y = 0,
    w = img:get_width(),
    h = img:get_height()
  }
  local temp_des_rec = {
    x = xi,
    y = yi,
    w = img:get_width(),
    h = img:get_height()
  }
  text_surface:copyfrom(img, temp_src_rec, temp_des_rec, true)
  -- gfx.update()
end

--- Initialize the screen destination coordinates by zooming
-- <<TESTED AND WORKING ON STB>>
--@param x (The x-position of the screen's upper left corner) [Integer]
--@param y (The y-position of the screen's upper left corner) [Integer]
--@param zoom (The zooming size)
--@return text_surface_des_rec The destination position of the text_surface on the screen
--
function text_surface_pos_on_des_zoom(x, y, zoom)
  -- body
  -- initialize the cordinator that the text surface on the screen
  local text_surface_des_rec = {
    x = x,
    y = y,
    w = (text_surface:get_width())*zoom,
    h = (text_surface:get_height())*zoom
  }
  return text_surface_des_rec
end

--- Reset the text_xi, text_yi, line_len
-- <<TESTED AND WORKING ON THE STB>>
function surface_reset()
  -- body
  line_len = 0
  text_xi = 0
  text_yi = 0
end

--- Reset the text_xi, text_yi, line_len to get a new line
-- <<TESTED AND WORKING ON THE BOX>>
function new_line()
  -- body
  line_len = 0
  text_xi = 0
  text_yi = text_yi + letter_height
end

--- Parse the text (from the string to word, from the word to character) to patch up the surface with the character img parsed
--@param text (the text to print on the screen) [String]
--@param max_width (The maximum width the surface is allowed to occupy) [Integer]
--@param max_height (The maximum height the surface is allowed to occupy, if the text is too long it ends with "...") [Integer]
--@param letter_width (the width of the letter) [Integer]
--@param letter_height (the height of the letter) [Integer]
--@return null
function parse_text_to_surface(text, letter_width, letter_height, max_width, max_height)
  -- body
  local not_spanned = true
  -- match the word in the string
  for word in string.gmatch(text, "%w+") do
    -- If the word is too long to fit the surface width
    if(string.len(word) * letter_width > max_width) then
      -- Boolean to block the last segment of the for-loop
      not_spanned = false
      for i=1, string.len(word) do
        chr = string.byte(word, i)
        if(text_xi == max_width - letter_width) then
          fill_surface(comma, text_xi, text_yi)
          new_line();
          get_chr_img(chr,letter_width)
        else
          get_chr_img(chr,letter_width)
        end
        line_len = line_len + letter_width
      end
    elseif((string.len(word) * letter_width) > (max_width - line_len)) then
      new_line()
    end
    if(not_spanned) then
      for i=1, string.len(word) do
        chr = string.byte(word, i)
        get_chr_img(chr,letter_width)
        line_len = line_len + letter_width
      end
    end
    not_spanned = true
    text_xi = text_xi + letter_width
    line_len = line_len + letter_width
  end
end

--- Get all the space position that are needed to create a new line in the text and store in the table
--@param text - the text going to be parsed
--@param line_max_num_of_chr - the max number of the characters for a line
--@return text_space_table - the table storing the position of the spaces in text
local function text_space_store(text, line_max_num_of_chr)
  -- body
  local temp_chr
  local text_new_line_table = {}
  local p_index = 0
  local p_new_line_space = line_max_num_of_chr 
  for j=1, string.len(text) do
    temp_chr = string.byte(text,j)
    -- print("-----current_string "..string.sub(text,j,j+1)..", temp_chr "..temp_chr)
    if temp_chr == 32 then
       -- print("space found, j= "..j..", p_new_line_space"..p_new_line_space)
       if j > p_new_line_space +1 then
         -- print("p_index "..p_index..", p_new_line_space "..p_new_line_space)
         table.insert(text_new_line_table, p_index)
         p_new_line_space = p_index + line_max_num_of_chr
         -- print("after p_new_line_space "..p_new_line_space)
         p_index = j
       else 
         p_index = j
       end
    elseif temp_chr == 10 or temp_chr == 13 then
      -- print("return:"..j.. ", temp_chr:"..temp_chr)
       p_new_line_space = j + line_max_num_of_chr
       p_index = j
    end 
  end
  -- store the last space before the text ends.
  if string.len(text) > p_new_line_space + 1 then
    table.insert(text_new_line_table, p_index)
  end
  -- print("hej"..line_max_num_of_chr)
  -- for i=1, #text_new_line_table do
  --    print(text_new_line_table[i])
  -- end
  return text_new_line_table
end

--- Check the span of the text 
--@param text_new_line_table - the table which has the position of the space that need to create a new line for next step
--@param pos - the position
--@return 1 - spanned 0 - not spanned
local function check_span(text_new_line_table, pos)
  for i=1, #text_new_line_table do
    if pos == text_new_line_table[i] then
      return 1
    end
  end
  return 0
end

--- Parse the text (Support more characters) to patch up the surface with the character img parsed
--@param text (the text to print on the screen) [String]
--@param max_width (The maximum width the surface is allowed to occupy) [Integer]
--@param max_height (The maximum height the surface is allowed to occupy, if the text is too long it ends with "...") [Integer]
--@param letter_width (the width of the letter) [Integer]
--@param letter_height (the height of the letter) [Integer]
--@return null
function parse_text_to_surface_special(text, letter_width, letter_height, max_width, max_height)
  -- body
  local line_max_len = math.floor(max_width/letter_width) * letter_width
  local line_max_num_of_chr = math.floor(max_width/letter_width)
  local text_new_line_table = text_space_store(text, line_max_num_of_chr)
  for i=1, string.len(text) do
    chr = string.byte(text, i)
    if chr == 10 or chr == 13 then
      new_line()
    elseif(line_len > line_max_len) then
      new_line()
      get_chr_img(chr,letter_width)
      line_len = line_len + letter_width
    elseif chr == 32 then 
      if check_span(text_new_line_table, i) == 1 then 
        new_line()
      else
        text_xi = text_xi + letter_width
        line_len = line_len + letter_width
      end
    else
      get_chr_img(chr,letter_width)
      line_len = line_len + letter_width
    end
  end
end

---A function that transforms the text to uppercase
--@param mixed_text (The text string input) [String]
--@return text [String]
local function upper_text(mixed_text)
  -- body
  return string.upper(mixed_text)
end

---A function that transforms the text to lowercase
--@param mixed_text (The text string input) [String]
--@return text [String]
local function lower_text(mixed_text)
  -- body
  return string.lower(mixed_text)
end 

--- A function that prints a string on a surface. The surface size is dependent on the length of
-- the string as well as the restrictions of allowed maximum width and height. The parameters are:
--@param mixed_text (The string to be printed) [String]
--@param x (The x-position of the surface's upper left corner) [Integer]
--@param y (The y-position of the surface's upper left corner) [Integer]
--@param max_width (The maximum width the surface is allowed to occupy) [Integer]
--@param max_height (The maximum height the surface is allowed to occupy,
-- if the text is too long it ends with "...") [Integer]
--@param font (The name of the font as well as the size of it) [Table] 
--@param character_case (The type of the character wanted to be printed [uppercase or lowercase]) [String] 
--
function text_printer.print_text(mixed_text, x, y, max_width, max_height, font, character_case)
  
  if character_case == "uppercase" then
    text = upper_text(mixed_text)
  elseif character_case == "lowercase" then
    text = lower_text(mixed_text)
  else
    text = mixed_text
  end
  chr_table = font["font_table"]
  -- initialize the letter width and height
  letter_width = font["font_size"]["image_width"]
  letter_height = font["font_size"]["image_height"]
  -- set the surface height
  surface_height = cal_surface_height(max_width,max_height,letter_width,letter_height,x,y)
  -- set the surface width
  surface_width = cal_surface_width(max_width)

  -- initialize the new surface
  surface_initialize(surface_width,surface_height)

  -- initialize the screen destination cordinator
  local screen_des_rec = text_surface_pos_on_des(x, y)
  -- initialize the surface source cordinator
  local surface_src_rec = letter_crop_from_src(0,0)
  -- parse the text to each character and fill in the new surface
  parse_text_to_surface_special(text, letter_width, letter_height, max_width, max_height)
  screen:copyfrom(text_surface,surface_src_rec,screen_des_rec,true)
  surface_reset()
end

--- A function that prints a string on a surface with the zooming size that set by users. The parameters are:
--@param mixed_text (The string to be printed) [String]
--@param x (The x-position of the surface's upper left corner) [Integer]
--@param y (The y-position of the surface's upper left corner) [Integer]
--@param max_width (The maximum width the surface is allowed to occupy) [Integer]
--@param max_height (The maximum height the surface is allowed to occupy,
-- if the text is too long it ends with "...") [Integer]
--@param font (The name of the font as well as the size of it) [String] 
--@param character_case (The type of the character wanted to be printed [uppercase or lowercase]) [String] 
--@param zoom (The zooming size of the surface printed on the screen) [Integer]
--
function text_printer.print_text_zoom(mixed_text, x, y, max_width, max_height, font, character_case, zoom)
  
  if character_case == "uppercase" then
    text = upper_text(mixed_text)
  elseif character_case == "lowercase" then
    text = lower_text(mixed_text)
  else
    text = mixed_text
  end
  chr_table = font["font_table"]
  -- initialize the letter width and height
  letter_width = font["font_size"]["image_width"]
  letter_height = font["font_size"]["image_height"]
  -- set the surface height
  surface_height = cal_surface_height(max_width,max_height,letter_width,letter_height,x,y)
  -- set the surface width
  surface_width = cal_surface_width(max_width)

  -- initialize the new surface
  surface_initialize(surface_width,surface_height)

  -- initialize the screen destination cordinator
  local screen_des_rec = text_surface_pos_on_des_zoom(x, y, zoom)
  -- initialize the surface source cordinator
  local surface_src_rec = letter_crop_from_src(0,0)
  -- parse the text to each character and fill in the new surface
  parse_text_to_surface_special(text, letter_width, letter_height, max_width, max_height)
  screen:copyfrom(text_surface,surface_src_rec,screen_des_rec,true)
  surface_reset()
end

--- Function for testing printing text on the screen
local function main()
  print_text("There is a word called complicated but there are also several other long words like xylophone and interorganizational however from now on i will only continue to write text until i have a ong enough string to test on the box so far i am not doing great and i will probably add another text surface with the same text but with a different shape of the text box just to see how they differ to be done today is to make it visible that the text in the box is only a part of the whole text available and that there are more characters available like special characters that team three might need for their articles and headlines", 100, 100, 200, 600, "Li")
  print_text("There is a word called complicated but there are also several other long words like xylophone and interorganizational however from now on i will only continue to write text until i have a ong enough string to test on the box so far i am not doing great and i will probably add another text surface with the same text but with a different shape of the text box just to see how they differ to be done today is to make it visible that the text in the box is only a part of the whole text available and that there are more characters available like special characters that team three might need for their articles and headlines", 400, 100, 800, 400, "Li")
end

return text_printer
