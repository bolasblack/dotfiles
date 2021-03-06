local quotepattern = '([' .. ("%^$().[]*+-?"):gsub("(.)", "%%%1") .. '])'

local function escape(str)
  return str:gsub(quotepattern, "%%%1")
end

local function compileRoute(route)
  local parts = {"^"}
  local names = {}
  for a, b, c, d in route:gmatch("([^:]*):([_%a][_%w]*)(:?)([^:]*)") do
    if #a > 0 then
      parts[#parts + 1] = escape(a)
    end
    if #c > 0 then
      parts[#parts + 1] = "(.*)"
    else
      parts[#parts + 1] = "([^/]*)"
    end
    names[#names + 1] = b
    if #d > 0 then
      parts[#parts + 1] = escape(d)
    end
  end
  if #parts == 1 then
    return function (string)
      if string == route then
           return {}
       else
          if route == string:gsub("%/$", "") then
              return {}
          else
              if route:gsub("%/$", "") == string then
                  return {}
              end
          end
      end
    end
  end

  if #parts > 1 and not(parts[#parts]:match("%*%)")) then
    local lastComp = parts[#parts]
    if lastComp:sub(#lastComp) == "/" then
      lastComp = lastComp:sub(1, #lastComp - 1)
    end
    parts[#parts] = lastComp .. "%/?"
  end

  parts[#parts + 1] = "$"
  local pattern = table.concat(parts)
  return function (string)
    local matches = {string:match(pattern)}
    if #matches > 0 then
      local results = {}
      for i = 1, #matches do
        results[i] = matches[i]
        results[names[i]] = matches[i]
      end
      return results
    end
  end
end

return compileRoute
