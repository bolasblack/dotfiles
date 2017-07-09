local Server = requireModule('http_server/server')
local rawCode = requireModule('http_server/raw_code')
local menubar = requireModule('http_server/menubar')
local pathwatcher = requireModule('http_server/pathwatcher')

local httpServer = function()
  return Server:new()
    :use(rawCode)
    :use(menubar)
    :use(pathwatcher)
end

return httpServer
