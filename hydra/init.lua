
-- Lua Doc:    http://www.lua.org/manual/5.2/#functions
-- Hydra Doc:  http://sdegutis.github.io/hydra/
-- Hydra Repo: https://github.com/sdegutis/hydra
-- Hydra Wiki: https://github.com/sdegutis/hydra/wiki

require 'utils'
require 'menu'
require 'other'

local CONFIG_PATH = os.getenv("HOME") .. "/.hydra/"
pathwatcher.stopall()

hydra.alert("Hydra sample config loaded", 1.5)

-- Comment this if you don't want Hydra launches at login
autolaunch.set(true)

mod1 = {"cmd", "alt"}

-- Toggle window full/halfscreen [[[
function movewindow_fullscreen()
  local win, frame = getCurrFrame()
  local newframe = win:screen():frame_without_dock_or_menu()
  win:setframe(newframe)
end

function movewindow_halfscreen()
  local win, frame = getCurrFrame()
  local newframe = win:screen():frame_without_dock_or_menu()
  newframe.x = newframe.w / 4
  newframe.y = newframe.h / 4
  newframe.w = newframe.w / 2
  newframe.h = newframe.h / 2
  win:setframe(newframe)
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
  local newframe = win:screen():frame_without_dock_or_menu()
  newframe.w = newframe.w / 2
  newframe.x = newframe.w
  win:setframe(newframe)
end

function movewindow_lefthalf()
  local win, frame = getCurrFrame()
  local newframe = win:screen():frame_without_dock_or_menu()
  newframe.w = newframe.w / 2
  newframe.x = 0
  win:setframe(newframe)
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

