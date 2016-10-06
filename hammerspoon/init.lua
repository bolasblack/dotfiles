-- http://www.hammerspoon.org/docs/

local configDir = os.getenv('HOME') .. '/.hammerspoon/'
local utils = dofile(configDir .. 'utils.lua')
local debug = false

local bindWithFlagKeys = function(fn)
  local flagKeys = {'cmd', 'shift', 'ctrl', 'alt'}
  local avaliableGroups = {
    {},

    {'cmd'}, {'shift'}, {'ctrl'}, {'alt'},

    {'cmd', 'shift'}, {'cmd', 'ctrl'}, {'cmd', 'alt'},
    {'shift', 'ctrl'}, {'shift', 'alt'},
    {'ctrl', 'alt'},

    {'cmd', 'shift', 'ctrl'}, {'cmd', 'shift', 'alt'}, {'cmd', 'ctrl', 'alt'},
    {'shift', 'ctrl', 'alt'},

    {'cmd', 'shift', 'ctrl', 'alt'}
  }
  utils.forEach(fn, avaliableGroups)
end


local f18 = hs.hotkey.modal.new({}, 'F18')

local movements = {
  { 'h', 'LEFT'},
  { 'j', 'DOWN'},
  { 'k', 'UP'},
  { 'l', 'RIGHT'},
}
bindWithFlagKeys(function(flagKeys)
    for i, bnd in ipairs(movements) do
      f18:bind(
        flagKeys,
        bnd[1],
        nil,
        function()
          hs.eventtap.keyStroke(flagKeys, bnd[2])
          f18.triggered = true
        end
      )
    end
end)

local pressedF19 = function()
  f18.triggered = false
  f18:enter()
  if debug then
    hs.alert.show('Entered f18 mode')
  end
end
local releasedF19 = function()
  f18:exit()
  if not f18.triggered then
    hs.eventtap.keyStroke({}, 'TAB')
  end
  if debug then
    hs.alert.show('Leaved f18 mode')
  end
end
bindWithFlagKeys(function(flagKeys)
    hs.hotkey.bind(flagKeys, 'F19', pressedF19, releasedF19)
end)

hs.pathwatcher.new(
  configDir,
  function(files)
    doReload = false
    for _, file in pairs(files) do
      if file:sub(-4) == '.lua' then
        doReload = true
      end
    end
    if doReload then
      hs.reload()
    end
  end
):start()
hs.alert.show('Config loaded')
