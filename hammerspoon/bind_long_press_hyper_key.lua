local utils = requireModule('utils')

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

local bindLongPressHyperKey = function(key, fn)
  local f18 = hs.hotkey.modal.new({}, 'F18')

  local pressedHyperKey = function()
    f18.triggered = false
    f18:enter()
    print('Entered LongPressHyperKey mode')
  end

  local releasedHyperKey = function(flagKeys)
    return function()
      f18:exit()
      print('Leaved LongPressHyperKey mode')
      if not f18.triggered then
        hs.eventtap.keyStroke(flagKeys, key)
      end
    end
  end

  bindWithFlagKeys(function(flagKeys)
    hs.hotkey.bind(flagKeys, 'F19', pressedHyperKey, releasedHyperKey(flagKeys))
  end)

  fn(function(mods, key, message, pressedfn, releasedfn, repeatfn)
      if not mods then
        bindWithFlagKeys(function(flagKeys)
            f18:bind(
              flagKeys,
              key,
              message,
              function()
                if pressedfn then
                  pressedfn(flagKeys)
                  f18.triggered = true
                end
              end,
              function()
                if releasedfn then
                  releasedfn(flagKeys)
                  f18.triggered = true
                end
              end,
              function()
                if repeatfn then
                  repeatfn(flagKeys)
                  f18.triggered = true
                end
              end
          )
        end)
      end
  end)
end

return bindLongPressHyperKey
