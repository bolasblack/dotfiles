const eng = Application("Keyboard Maestro Engine")

// getVar :: string -> any
function getVar(varName) {
  return eng.getvariable(varName)
}

// setVar :: string -> any
function setVar(varName, data) {
  return eng.setvariable(varName, { to: data })
}
