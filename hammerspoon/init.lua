-- http://www.hammerspoon.org/docs/
-- https://learnxinyminutes.com/docs/zh-cn/lua-cn/
function requireModule(moduleName)
  local modulePath = configDir .. moduleName .. '.lua'
  print('-- Requiring module: ' .. modulePath)
  return dofile(modulePath)
end
configDir = os.getenv('HOME') .. '/.hammerspoon/'
requireModule('auto_reload_config')()

local movements = {
  { 'h', 'LEFT'  },
  { 'j', 'DOWN'  },
  { 'k', 'UP'    },
  { 'l', 'RIGHT' },
}
requireModule('bind_long_press_hyper_key')('TAB', function(bind)
  for i, bnd in ipairs(movements) do
    bind(nil, bnd[1], nil, function(flagKeys)
      hs.eventtap.keyStroke(flagKeys, bnd[2])
    end)
  end
end)
--[[ TODO:
bind(nil, {'f19', 'j'}, nil, function(event)
    hs.eventtap.keyStroke(event.mods, 'left')
end)
--]]
