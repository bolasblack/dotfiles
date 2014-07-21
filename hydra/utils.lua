
function getCurrFrame()
  local win = window.focusedwindow()
  local frame = win:frame()
  return win, frame
end

