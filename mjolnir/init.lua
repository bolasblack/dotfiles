
-- Lua Doc:    http://www.lua.org/manual/5.2/#functions
-- Mjolnir Repo: https://github.com/sdegutis/mjolnir

--[[
Required modules:

mjolnir.alert
mjolnir.hotkey

mjolnir._asm.ipc.cli
mjolnir._asm.pathwatcher
mjolnir._asm.hydra
--]]


local alert = require 'mjolnir.alert'
local hotkey = require 'mjolnir.hotkey'
local window = require 'mjolnir.window'
local fnutils = require 'mjolnir.fnutils'
local hydra = require 'mjolnir._asm.hydra'
local pathwatcher = require 'mjolnir._asm.pathwatcher'
local ipc = require 'mjolnir._asm.ipc'

mjolnir.configdir = os.getenv("HOME") .. "/.mjolnir/"
mod1 = {"cmd", "alt"}

function fnutils.every(table, fn)
  for k, v in pairs(table) do
    if not fn(v, k) then return false end
  end
  return true
end
function fnutils.some(table, fn)
  local function is_invalid(v, k)
    return not fn(v, k)
  end
  return not fnutils.every(table, is_invalid)
end

function getCurrFrame()
  local win = window.focusedwindow()
  if not win then
     win = window.orderedwindows()[1]
  end
  local frame = win:frame()
  return win, frame
end

-- Toggle window full/halfscreen [[[
function movewindow_fullscreen()
  local win, frame = getCurrFrame()
  win:maximize()
end

function movewindow_halfscreen()
  local win, frame = getCurrFrame()
  frame.x = frame.w / 4
  frame.y = frame.h / 4
  frame.w = frame.w / 2
  frame.h = frame.h / 2
  win:setframe(frame)
end

function movewindow_toggle_fullscreen()
  local win, frame = getCurrFrame()
  if frame.x == 0 then
    movewindow_halfscreen()
  else
    movewindow_fullscreen()
  end
end

hotkey.bind(mod1, "1", movewindow_toggle_fullscreen)
-- ]]]

-- Toggle window left/right half [[[
function movewindow_righthalf()
  local win, frame = getCurrFrame()
  win:maximize()
  frame = win:frame()
  frame.w = frame.w / 2
  frame.x = frame.w
  win:setframe(frame)
end

function movewindow_lefthalf()
  local win, frame = getCurrFrame()
  win:maximize()
  frame = win:frame()
  frame.w = frame.w / 2
  frame.x = 0
  win:setframe(frame)
end

function movewindow_toggle_half()
  local win, frame = getCurrFrame()
  if frame.x == 0 then
    movewindow_righthalf()
  else
    movewindow_lefthalf()
  end
end

hotkey.bind(mod1, "2", movewindow_toggle_half)
--- ]]]

if package.searchpath('customize', package.path) then
  require 'customize'
  package.loaded['customize'] = nil
end

alert.show("Hydra sample config loaded", 1.5)

hydra.autolaunch(true)

pathwatcher.new(
  os.getenv("HOME") .. '/.mjolnir/',
  function (changedfiles)
    local function is_lua_file(filename)
      return string.match(filename, '.lua')
    end
    if not fnutils.every(changedfiles, is_lua_file) then return end
    mjolnir.reload()
  end
):start()
