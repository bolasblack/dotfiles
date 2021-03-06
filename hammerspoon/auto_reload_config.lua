local function autoReloadConfig()
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
end

return autoReloadConfig
