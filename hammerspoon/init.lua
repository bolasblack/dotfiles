-- http://www.hammerspoon.org/docs/
-- https://learnxinyminutes.com/docs/zh-cn/lua-cn/
function requireModule(moduleName)
  local modulePath = configDir .. moduleName .. '.lua'
  print('-- Requiring module: ' .. modulePath)
  return dofile(modulePath)
end

function loadstring(str)
  local fileName = os.tmpname()
  local file = io.open(fileName, 'w+')
  file:write(str)
  file:close()
  local fn = loadfile(fileName)
  os.remove(fileName)
  return fn
end

libraryDir = os.getenv('HOME') .. '/Library/'
configDir = os.getenv('HOME') .. '/.hammerspoon/'
requireModule('auto_reload_config')()
requireModule('http_server')()
