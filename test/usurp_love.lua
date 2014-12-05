--
-- Usurpate the love library for unit testing
--
-- Author:    Alexandre Thieriot
--
-- Created:   19/10/2014
-- Copyright: TAP Interactive
--

local table = table

local stack = {}
local _callstack = {}
stack['_callstack'] = _callstack

local function arguments(...)
  local listR = {}
  for _, e in ipairs({...}) do
    table.insert(listR, e)
  end
  table.insert(_callstack, listR)
end

function stack._clear_callstack()
  _callstack = {}
  stack['_callstack'] = _callstack
end

local list = {}
stack['graphics'] = list

function list.setPointSize(...)
  arguments(list, 'setPointSize', ...)
end

function list.setPointStyle(...)
  arguments(list, 'setPointStyle', ...)
end

function list.setColor(...)
  arguments(list, 'setColor', ...)
end

function list.point(...)
  arguments(list, 'point', ...)
end

function list.rectangle(...)
  arguments(list, 'rectangle', ...)
end

function list.setColorstackode(...)
  arguments(list, 'setColorstackode', ...)
end

function list.setLineWidth(...)
  arguments(list, 'setLineWidth', ...)
end

function list.print(...)
  arguments(list, 'print', ...)
end

function list.setFont(...)
  arguments(list, 'setFont', ...)
end

local listFont = {}
function list.newFont(...)
  arguments(list, 'newFont', ...)
  return listFont
end

function listFont.getWidth(...)
  arguments(listFont, 'getWidth', ...)
  return 32
end

function listFont.getHeight()
  arguments(listFont, 'getHeight')
  return 32
end

function list.draw(...)
  arguments(list, 'draw', ...)
end

local mock_image = {}

function list.newImage(...)
  arguments(list, 'newImage', ...)
  return mock_image
end

function mock_image.getWidth()
  arguments(mock_image, 'getWidth')
  return 1600
end

function mock_image.getHeight()
  arguments(mock_image, 'getHeight')
  return 900
end

local me = {}
stack['event'] = me
function me.push(...)
  arguments(me, 'push', ...)
end

-- Mock Window
local mock_window = {}
stack['window'] = mock_window

function mock_window.getDesktopDimensions(...)
  arguments(mock_window, 'getDesktopDimensions')
  local dim = {}
  return dim
end

--Mock Image
local mock_image = {}
stack['image'] = mock_image

local mock_imageData = {
  width = 1600,
  height = 900
}

function mock_image.newImageData(...)
  arguments(mock_image, 'newImageData', ...)
  return mock_imageData
end

function mock_imageData.getWidth()
  return mock_imageData.width
end

function mock_imageData.getHeight()
  return mock_imageData.height
end

function mock_imageData.paste(...)
  arguments(mock_imageData, 'paste', ...)
end

function mock_imageData.setPixel(...)
  arguments(mock_imageData, 'setPixel', ...)
end

--Mock keyboard
local mock_keyboard = {}
stack['keyboard'] = mock_keyboard

function mock_keyboard.setKeyRepeat( ... )
  arguments(mock_keyboard, 'setKeyRepeat', ...)
end

return stack