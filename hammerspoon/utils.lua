local infinity = '#utils#infinity#'

local reduced = function(value)
  return {
    reduced = true,
    value = value
  }
end

local reduce = function(iteratee, initValue, table)
  if table == infinity then
    local loopIndex = 0
    repeat
      loopIndex = loopIndex + 1
      local result = iteratee(initValue, loopIndex, loopIndex, infinity)
      if type(result) == 'table' and result.reduced then
        return result.value
      else
        initValue = result
      end
    until false
  else
    for i, v in pairs(table) do
      local result = iteratee(initValue, v, i, table)
      if type(result) == 'table' and result.reduced then
        return result.value
      else
        initValue = result
      end
    end
  end
  return initValue
end

local map = function(iteratee, table)
  return reduce(
    function(initValue, v, i, table)
      initValue[i] = iteratee(v, i, table)
      return initValue
    end,
    {},
    table
  )
end

local forEach = function(iteratee, table)
  return reduce(
    function(initValue, v, i, table)
      iteratee(v, i, table)
      return initValue
    end,
    table,
    table
  )
end

local find = function(iteratee, table)
  return reduce(
    function(_, v, i, table)
      if iteratee(v, i, table) then
        return reduced(v)
      end
    end,
    nil,
    table
  )
end

local every = function(iteratee, table)
  return reduce(
    function(_, v, i)
      if not iteratee(v, i, table) then
        return reduced(false)
      end
      return true
    end,
    true,
    table
  )
end

local some = function(iteratee, table)
  return reduce(
    function(_, v, i)
      if iteratee(v, i, table) then
        return reduced(true)
      end
      return false
    end,
    false,
    table
  )
end

local shallowCopy = function(obj)
  return reduce(
    function(memo, v, i)
      memo[i] = v
      return memo
    end,
    {},
    obj
  )
end

local equal = function(obj1, obj2, shallow)
  if type(obj1) ~= 'table' or type(obj2) ~= 'table' then
    return obj1 == obj2
  end
  shallow = (shallow or true)
  return every(
    function(value, key)
      if shallow then
        return value == obj1[key]
      else
        return equal(value, obj2[key])
      end
    end,
    obj1
  )
end

local utils = {
  reduce = reduce,
  reduced = reduced,
  infinity = infinity,
  find = find,
  map = map,
  forEach = forEach,
  some = some,
  every = every,
  shallowCopy = shallowCopy,
}
return utils
