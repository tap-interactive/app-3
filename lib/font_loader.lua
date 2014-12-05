--- Font_loader Module
-- Integration of the functions for printing text on the screen
-- used as a help library
-- Fonts [UbuntuMono Bold Capital for Headlines] [Anonymous Pro Bold for Ingress] [Anoymous Pro Regular for Article]
-- @module font_loader
-- @author Li
-- @copyright FeedMe@TAP interactive

font_loader = {}

AnonymousProReg_font_path = "/src/data/font/AnonymousProReg/"
AnonymousProBold_font_path = "/src/data/font/AnonymousProBold/"
UbuntuMono_font_path = "/src/data/font/UbuntuMono/"
UbuntuMonoBold_font_path = "/src/data/font/UbuntuMonoBold/"
TimesNewRoman_font_path = "/src/data/font/Li/"

font_size_setting = {UbuntuMonoBold = {image_width = 16, image_height = 26}, UbuntuMono={image_width = 16, image_height = 31}, AnonymousProReg = {image_width = 17, image_height = 26}, AnonymousProBold = {image_width = 16, image_height = 26}}
fonts = {}

--- Load the font at the beginning of printing text
-- <<>>
--@param font_path (The path of the font is going to be used) [String]
--@return null
local function load_fonts(font_path)
  -- body
  -- load and initialize 26 letters (uppercase and lowercase)
  local upper_a = gfx.loadpng(font_path.."uppercase_a.png")
  upper_a:premultiply()
  local upper_b = gfx.loadpng(font_path.."uppercase_b.png")
  upper_b:premultiply()
  local upper_c = gfx.loadpng(font_path.."uppercase_c.png")
  upper_c:premultiply()
  local upper_d = gfx.loadpng(font_path.."uppercase_d.png")
  upper_d:premultiply()
  local upper_e = gfx.loadpng(font_path.."uppercase_e.png")
  upper_e:premultiply()
  local upper_f = gfx.loadpng(font_path.."uppercase_f.png")
  upper_f:premultiply()
  local upper_g = gfx.loadpng(font_path.."uppercase_g.png")
  upper_g:premultiply()
  local upper_h = gfx.loadpng(font_path.."uppercase_h.png")
  upper_h:premultiply()
  local upper_i = gfx.loadpng(font_path.."uppercase_i.png")
  upper_i:premultiply()
  local upper_j = gfx.loadpng(font_path.."uppercase_j.png")
  upper_j:premultiply()
  local upper_k = gfx.loadpng(font_path.."uppercase_k.png")
  upper_k:premultiply()
  local upper_l = gfx.loadpng(font_path.."uppercase_l.png")
  upper_l:premultiply()
  local upper_m = gfx.loadpng(font_path.."uppercase_m.png")
  upper_m:premultiply()
  local upper_n = gfx.loadpng(font_path.."uppercase_n.png")
  upper_n:premultiply()
  local upper_o = gfx.loadpng(font_path.."uppercase_o.png")
  upper_o:premultiply()
  local upper_p = gfx.loadpng(font_path.."uppercase_p.png")
  upper_p:premultiply()
  local upper_q = gfx.loadpng(font_path.."uppercase_q.png")
  upper_q:premultiply()
  local upper_r = gfx.loadpng(font_path.."uppercase_r.png")
  upper_r:premultiply()
  local upper_s = gfx.loadpng(font_path.."uppercase_s.png")
  upper_s:premultiply()
  local upper_t = gfx.loadpng(font_path.."uppercase_t.png")
  upper_t:premultiply()
  local upper_u = gfx.loadpng(font_path.."uppercase_u.png")
  upper_u:premultiply()
  local upper_v = gfx.loadpng(font_path.."uppercase_v.png")
  upper_v:premultiply()
  local upper_w = gfx.loadpng(font_path.."uppercase_w.png")
  upper_w:premultiply()
  local upper_x = gfx.loadpng(font_path.."uppercase_x.png")
  upper_x:premultiply()
  local upper_y = gfx.loadpng(font_path.."uppercase_y.png")
  upper_y:premultiply()
  local upper_z = gfx.loadpng(font_path.."uppercase_z.png")
  upper_z:premultiply()

  local a = gfx.loadpng(font_path.."a.png")
  a:premultiply()
  local b = gfx.loadpng(font_path.."b.png")
  b:premultiply()
  local c = gfx.loadpng(font_path.."c.png")
  c:premultiply()
  local d = gfx.loadpng(font_path.."d.png")
  d:premultiply()
  local e = gfx.loadpng(font_path.."e.png")
  e:premultiply()
  local f = gfx.loadpng(font_path.."f.png")
  f:premultiply()
  local g = gfx.loadpng(font_path.."g.png")
  g:premultiply()
  local h = gfx.loadpng(font_path.."h.png")
  h:premultiply()
  local i = gfx.loadpng(font_path.."i.png")
  i:premultiply()
  local j = gfx.loadpng(font_path.."j.png")
  j:premultiply()
  local k = gfx.loadpng(font_path.."k.png")
  k:premultiply()
  local l = gfx.loadpng(font_path.."l.png")
  l:premultiply()
  local m = gfx.loadpng(font_path.."m.png")
  m:premultiply()
  local n = gfx.loadpng(font_path.."n.png")
  n:premultiply()
  local o = gfx.loadpng(font_path.."o.png")
  o:premultiply()
  local p = gfx.loadpng(font_path.."p.png")
  p:premultiply()
  local q = gfx.loadpng(font_path.."q.png")
  q:premultiply()
  local r = gfx.loadpng(font_path.."r.png")
  r:premultiply()
  local s = gfx.loadpng(font_path.."s.png")
  s:premultiply()
  local t = gfx.loadpng(font_path.."t.png")
  t:premultiply()
  local u = gfx.loadpng(font_path.."u.png")
  u:premultiply()
  local v = gfx.loadpng(font_path.."v.png")
  v:premultiply()
  local w = gfx.loadpng(font_path.."w.png")
  w:premultiply()
  local x = gfx.loadpng(font_path.."x.png")
  x:premultiply()
  local y = gfx.loadpng(font_path.."y.png")
  y:premultiply()
  local z = gfx.loadpng(font_path.."z.png")
  z:premultiply()
  -- load numbers 
  local chr_0 = gfx.loadpng(font_path.."0.png")
  chr_0:premultiply()
  local chr_1 = gfx.loadpng(font_path.."1.png")
  chr_1:premultiply()
  local chr_2 = gfx.loadpng(font_path.."2.png")
  chr_2:premultiply()
  local chr_3 = gfx.loadpng(font_path.."3.png")
  chr_3:premultiply()
  local chr_4 = gfx.loadpng(font_path.."4.png")
  chr_4:premultiply()
  local chr_5 = gfx.loadpng(font_path.."5.png")
  chr_5:premultiply()
  local chr_6 = gfx.loadpng(font_path.."6.png")
  chr_6:premultiply()
  local chr_7 = gfx.loadpng(font_path.."7.png")
  chr_7:premultiply()
  local chr_8 = gfx.loadpng(font_path.."8.png")
  chr_8:premultiply()
  local chr_9 = gfx.loadpng(font_path.."9.png")
  chr_9:premultiply()

  -- load ascii 33~47
  -- local space = gfx.loadpng(font_path.."32.png")
  local exclamation_mark = gfx.loadpng(font_path.."33.png")
  exclamation_mark:premultiply()
  local double_quotation_mark = gfx.loadpng(font_path.."34.png")
  double_quotation_mark:premultiply()
  local pound = gfx.loadpng(font_path.."35.png")
  pound:premultiply()
  local dolar = gfx.loadpng(font_path.."36.png")
  dolar:premultiply()
  local percent = gfx.loadpng(font_path.."37.png")
  percent:premultiply()
  local ampersand = gfx.loadpng(font_path.."38.png")
  ampersand:premultiply()
  local single_quotation_mark = gfx.loadpng(font_path.."39.png")
  single_quotation_mark:premultiply()
  local round_bracket_left = gfx.loadpng(font_path.."40.png")
  round_bracket_left:premultiply()
  local round_bracket_right = gfx.loadpng(font_path.."41.png")
  round_bracket_right:premultiply()
  local asterisk = gfx.loadpng(font_path.."42.png")
  asterisk:premultiply()
  local plus = gfx.loadpng(font_path.."43.png")
  plus:premultiply()
  local comma = gfx.loadpng(font_path.."44.png")
  comma:premultiply()
  local minus = gfx.loadpng(font_path.."45.png")
  minus:premultiply()
  local dot = gfx.loadpng(font_path.."46.png")
  dot:premultiply()
  local slash = gfx.loadpng(font_path.."47.png")
  slash:premultiply()
  
  --load ascii 58~64
  local colon = gfx.loadpng(font_path.."58.png")
  colon:premultiply()
  local semicolon = gfx.loadpng(font_path.."59.png")
  semicolon:premultiply()
  local less_than_sign = gfx.loadpng(font_path.."60.png")
  less_than_sign:premultiply()
  local equal = gfx.loadpng(font_path.."61.png")
  equal:premultiply()
  local more_than_sign = gfx.loadpng(font_path.."62.png")
  more_than_sign:premultiply()
  local question_mark = gfx.loadpng(font_path.."63.png")
  question_mark:premultiply()
  local at = gfx.loadpng(font_path.."64.png")
  at:premultiply()
  
  --load ascii 91~96
  local square_bracket_left = gfx.loadpng(font_path.."91.png")
  square_bracket_left:premultiply()
  local back_slash = gfx.loadpng(font_path.."92.png")
  back_slash:premultiply()
  local square_bracket_right = gfx.loadpng(font_path.."93.png")
  square_bracket_right:premultiply()
  local caret = gfx.loadpng(font_path.."94.png")
  caret:premultiply()
  local underscore = gfx.loadpng(font_path.."95.png")
  underscore:premultiply()
  local backquote = gfx.loadpng(font_path.."96.png")
  backquote:premultiply()

  --load ascii 123~126
  local left_brace = gfx.loadpng(font_path.."123.png")
  left_brace:premultiply()
  local vertical_line = gfx.loadpng(font_path.."124.png")
  vertical_line:premultiply()
  local right_brace = gfx.loadpng(font_path.."125.png")
  right_brace:premultiply()
  local wave_line = gfx.loadpng(font_path.."126.png")
  wave_line:premultiply()

  -- create the table for mapping ASCII code to the character_img
  -- <<TESTED AND WORKING ON THE BOX>>
  local font_chr_mapping_table = {
    {id = 33,img = exclamation_mark},
    {id = 34,img = double_quotation_mark},
    {id = 35,img = pound},
    {id = 36,img = dolar},
    {id = 37,img = percent},
    {id = 38,img = ampersand},
    {id = 39,img = single_quotation_mark},
    {id = 40,img = round_bracket_left},
    {id = 41,img = round_bracket_right},
    {id = 42,img = asterisk},
    {id = 43,img = plus},
    {id = 44,img = comma},
    {id = 45,img = minus},
    {id = 46,img = dot},
    {id = 47,img = slash},

    {id = 48,img = chr_0},
    {id = 49,img = chr_1},
    {id = 50,img = chr_2},
    {id = 51,img = chr_3},
    {id = 52,img = chr_4},
    {id = 53,img = chr_5},
    {id = 54,img = chr_6},
    {id = 55,img = chr_7},
    {id = 56,img = chr_8},
    {id = 57,img = chr_9},

    {id = 58,img = colon},
    {id = 59,img = semicolon},
    {id = 60,img = less_than_sign},
    {id = 61,img = equal},
    {id = 62,img = more_than_sign},
    {id = 63,img = question_mark},
    {id = 64,img = at},

    {id = 91,img = square_bracket_left},
    {id = 92,img = back_slash},
    {id = 93,img = square_bracket_right},
    {id = 94,img = caret},
    {id = 95,img = underscore},
    {id = 96,img = backquote},

    {id = 65,img = upper_a},
    {id = 66,img = upper_b},
    {id = 67,img = upper_c},
    {id = 68,img = upper_d},
    {id = 69,img = upper_e},
    {id = 70,img = upper_f},
    {id = 71,img = upper_g},
    {id = 72,img = upper_h},
    {id = 73,img = upper_i},
    {id = 74,img = upper_j},
    {id = 75,img = upper_k},
    {id = 76,img = upper_l},
    {id = 77,img = upper_m},
    {id = 78,img = upper_n},
    {id = 79,img = upper_o},
    {id = 80,img = upper_p},
    {id = 81,img = upper_q},
    {id = 82,img = upper_r},
    {id = 83,img = upper_s},
    {id = 84,img = upper_t},
    {id = 85,img = upper_u},
    {id = 86,img = upper_v},
    {id = 87,img = upper_w},
    {id = 88,img = upper_x},
    {id = 89,img = upper_y},
    {id = 90,img = upper_z},

    {id = 97,img = a},
    {id = 98,img = b},
    {id = 99,img = c},
    {id = 100,img = d},
    {id = 101,img = e},
    {id = 102,img = f},
    {id = 103,img = g},
    {id = 104,img = h},
    {id = 105,img = i},
    {id = 106,img = j},
    {id = 107,img = k},
    {id = 108,img = l},
    {id = 109,img = m},
    {id = 110,img = n},
    {id = 111,img = o},
    {id = 112,img = p},
    {id = 113,img = q},
    {id = 114,img = r},
    {id = 115,img = s},
    {id = 116,img = t},
    {id = 117,img = u},
    {id = 118,img = v},
    {id = 119,img = w},
    {id = 120,img = x},
    {id = 121,img = y},
    {id = 122,img = z},

    {id = 123,img = left_brace},
    {id = 124,img = vertical_line},
    {id = 125,img = right_brace},
    {id = 126,img = wave_line}

  }
  return font_chr_mapping_table
end


--- [[ Fonts initialization ]]
--<<TESTED AND WORKING ON THE STB>>
fonts = {
  ubuntumonobold = {font_table = load_fonts(UbuntuMonoBold_font_path), font_size = font_size_setting["UbuntuMonoBold"]}, 
  anonymousprobold = {font_table = load_fonts(AnonymousProBold_font_path), font_size = font_size_setting["AnonymousProBold"]}
} 

--ubuntunmono = {font_table = load_fonts(UbuntuMono_font_path),font_size = font_size_setting["UbuntuMono"]}, 
--anonymousproreg = {font_table = load_fonts(AnonymousProReg_font_path), font_size = font_size_setting["AnonymousProReg"]}, 
--- Get the fonts
-- <<>>
--@return fonts - the fonts table and fonts size
function font_loader.get_fonts()
  -- body
  return fonts
end

return font_loader
