package.path = package.path .. ';~/.luarocks/share/lua/5.2/?'
require('busted.runner')()
local utils = require('utils')

describe('utils.lua', function()
  describe('.reduce', function()
    it('works', function()
      local result = utils.reduce(
        function(memo, value, index)
          return memo + value + index
        end,
        0,
        {1,2,3,4}
      )

      assert.are.same(result, 20)
    end)

    it('work with .reduced()', function()
      local result = utils.reduce(
        function(memo, value, index)
          if index == 3 then
            return utils.reduced(memo + value + index)
          else
            return memo + value + index
          end
        end,
        0,
        {1,2,3,4}
      )

      assert.are.same(result, 12)
    end)
  end)

  describe('.equal', function()
    it('works with shallow table', function()
      local result1 = utils.equals({1, a = 1, 2, b = 2}, {1, a = 1, 2, b = 2})
      local result2 = utils.equals({1, a = 1, 2, b = 2}, {1, 2})
      local result3 = utils.equals({1, a = 1, 2, b = 2}, {a = 1, b = 2})
      assert.is_true(result1)
      assert.is_false(result2)
      assert.is_false(result3)
    end)

    it('works in shallow mode', function()
      local data = {1, 2}
      local result1 = utils.equals({1, a = 1, 2, b = 2, {1, 2}}, {1, a = 1, 2, b = 2, {1, 2}}, true)
      local result2 = utils.equals({1, a = 1, 2, b = 2, c = {1, 2}}, {1, a = 1, 2, b = 2, c = {1, 2}}, true)
      local result3 = utils.equals({1, a = 1, 2, b = 2, data}, {1, a = 1, 2, b = 2, data}, true)
      local result4 = utils.equals({1, a = 1, 2, b = 2, c = data}, {1, a = 1, 2, b = 2, c = data}, true)
      assert.is_false(result1)
      assert.is_false(result2)
      assert.is_true(result3)
      assert.is_true(result4)
    end)

    it('works in deep mode', function()
      local data = {1, 2}
      local result1 = utils.equals({1, a = 1, 2, b = 2, {1, 2}}, {1, a = 1, 2, b = 2, {1, 2}}, false)
      local result2 = utils.equals({1, a = 1, 2, b = 2, c = {1, 2}}, {1, a = 1, 2, b = 2, c = {1, 2}}, false)
      local result3 = utils.equals({1, a = 1, 2, b = 2, data}, {1, a = 1, 2, b = 2, data}, false)
      local result4 = utils.equals({1, a = 1, 2, b = 2, c = data}, {1, a = 1, 2, b = 2, c = data}, false)
      local result5 = utils.equals({1, a = 1, 2, b = 2, {1, {1, 2}}}, {1, a = 1, 2, b = 2, {1, {1, 2}}}, false)
      local result6 = utils.equals({1, a = 1, 2, b = 2, c = {1, {1, 2}}}, {1, a = 1, 2, b = 2, c = {1, {1, 2}}}, false)
      assert.is_true(result1)
      assert.is_true(result2)
      assert.is_true(result3)
      assert.is_true(result4)
      assert.is_true(result5)
      assert.is_true(result6)
    end)
  end)
end)
