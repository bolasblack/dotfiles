local utils = requireModule('utils')
local httpUtils = requireModule('http_server/utils')

local escapeEncodedURIComponent = function(str)
  return string.gsub(str, '%%', '%%%%')
end

local pathwatcher = function(server)
  local pathwatcherDB = {}

  server:route(
    'get', '/pathwatchers',
    function(req, res)
      local result = utils.map(
        function(config)
          local newConfig = utils.shallowCopy(config)
          newConfig.watcher = nil
          return newConfig
        end,
        pathwatcherDB
      )
      res.body = hs.json.encode(result)
    end
  )

  --[[
    {
      id: String,
      path: String,
      type: 'command' | 'notify',
      data: Any,
      command: ['/bin/ls', '-a', '-l', '{files}', '{id}', '{data}'],
      urlencode: Boolean, // default: false
    }
  ]]--
  server:route(
    'post', '/pathwatchers',
    function(req, res)
      local config = hs.json.decode(req.body)
      local watcher = hs.pathwatcher.new(
        config.path,
        function(_files)
          if config.type == 'notify' then
            server.nativeServer:send(hs.json.encode({
              type = 'pathwatcher:change',
              id = config.id,
              files = _files,
              data = config.data,
            }))
          elseif config.type == 'command' then
            local files, id, data
            if config.urlencode then
              id = escapeEncodedURIComponent(httpUtils.encodeURIComponent(config.id))
              files = escapeEncodedURIComponent(httpUtils.encodeURIComponent(hs.json.encode(_files)))
              if config.data then
                if type(config.data) == 'table' then
                  data = escapeEncodedURIComponent(httpUtils.encodeURIComponent(hs.json.encode(config.data)))
                else
                  data = escapeEncodedURIComponent(httpUtils.encodeURIComponent(tostring(config.data)))
                end
              else
                data = "null"
              end
            else
              files = _files
              id = config.id
              data = config.data
            end

            hs.task.new(
              config.command[1],
              function() end,
              function() return true end,
              utils.map(
                function(arg)
                  local result
                  if string.find(arg, '{files}') then
                    result = string.gsub(arg, '{files}', files)
                  elseif string.find(arg, '{id}') then
                    result = string.gsub(arg, '{id}', id)
                  elseif string.find(arg, '{data}') then
                    result = string.gsub(arg, '{data}', data)
                  else
                    result = arg
                  end
                  return result
                end,
                utils.slice(2, utils.infinity, config.command)
              )
            ):start()
          end
        end
      ):start()
      local newConfig = utils.shallowCopy(config)
      newConfig.watcher = watcher
      table.insert(pathwatcherDB, newConfig)
      res.status = 201
    end
  )

  server:route(
    'delete', '/pathwatchers/:id',
    function(req, res)
      pathwatcherDB = utils.filter(
        function(record)
          if record.id == req.params.id then
            record.watcher:stop()
            return false
          else
            return true
          end
        end,
        pathwatcherDB
      )
    end
  )
end

return pathwatcher
