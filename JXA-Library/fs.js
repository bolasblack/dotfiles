// existsSync :: string -> boolean
function existsSync(strPath) {
  const error = $()
  $.NSFileManager.defaultManager.attributesOfItemAtPathError(
    $(strPath).stringByStandardizingPath,
    error,
  )
  return error.code == null
}

// readFileSync :: string -> String | null
function readFileSync(strPath) {
  const error = $()
  const str = ObjC.unwrap(
    $.NSString.stringWithContentsOfFileEncodingError(
      $(strPath).stringByStandardizingPath,
      $.NSUTF8StringEncoding,
      error,
    ),
  )
  return error.code == null ? str : null
}
