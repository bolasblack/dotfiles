local compileRoute = requireModule('http_server/compile_route')

local Server = {}

function Server:new()
  local newServer = {
    _registeredRoutes = {},
  }

  local server = hs.httpserver.new()
    :setInterface('127.0.0.1')
    :setName('hammerspoon')
    :websocket('/ws', function(msg) end)
    :setCallback(function(method, path, headers, body)
        local req = {
          method = method,
          path = path,
          headers = headers,
          body = body,
        }

        local res = {
          body = '',
          status = 200,
          headers = { ["Content-Type"] = "text/plain" },
        }

        print('method ' .. method ..
            ', path ' .. path ..
            ', headers ' .. hs.inspect.inspect(headers) ..
            ', body ' .. body)

        local callIndexedRouteFn
        callIndexedRouteFn = function(index)
          local routeFn = newServer._registeredRoutes[index]
          return function()
            if routeFn then
              routeFn(req, res, callIndexedRouteFn(index + 1))
            end
          end
        end
        callIndexedRouteFn(1)()

        print('handled req ' .. hs.inspect.inspect(res))

        return res.body, res.status, res.headers
      end)
    :start()

  print('started server at ' .. server:getInterface() .. ':' .. server:getPort())

  newServer.nativeServer = server

  self.__index = self

  return setmetatable(newServer, self)
end

function Server:route(method, path, fn)
  local compiledPath = compileRoute(path)
  table.insert(
    self._registeredRoutes,
    function(req, res, next)
      if string.lower(req.method) ~= string.lower(method) and
         string.lower(method) ~= 'all' then
        return next()
      end

      local pathname, query = string.match(req.path, "^([^?]*)%??(.*)")
      local params = compiledPath(pathname)
      if not params and pathname ~= path then
        return next()
      end

      req.params = params or {}

      return fn(req, res, next)
    end
  )
end

function Server:use(fn)
  fn(self)
  return self
end

return Server
