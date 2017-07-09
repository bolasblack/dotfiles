local menubar = function(server)
  local menubarDB = {}

  server:route(
    'get', '/menubars',
    function(req, res)
      res.headers['Content-Type'] = 'application/json'
      print('menubarDB', hs.inspect.inspect(menubarDB))
      res.body = hs.json.encode(menubarDB, true)
    end
  )

  server:route(
    'post', '/menubars',
    function(req, res)
      table.insert(menubarDB, req.body)
      res.body = tostring(#menubarDB)
      res.status = 201
    end
  )

  server:route(
    'delete', '/menubars/:id',
    function(req, res)
      local index = tonumber(req.params.id)
      if index then
        menubarDB[index] = nil
      else
        res.status = 404
      end
    end
  )
end

return menubar
