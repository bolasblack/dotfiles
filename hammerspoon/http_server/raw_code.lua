local utils = requireModule('utils')

local rawCode = function(server)
  server:route(
    'post', '/raw_shell',
    function(req, res)
      if not utils.isEmpty(req.body) then
      end
    end
  )

  server:route(
    'post', '/raw_code',
    function(req, res)
      if utils.isEmpty(req.body) then
        res.body = 'OK'
      else
        local fn = loadstring(req.body)
        if fn then
          res.body = fn()
        else
          res.status = 400
        end
      end
      return res
    end
  )
end

return rawCode
