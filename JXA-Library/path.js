// normalize :: string -> string
function normalize(path) {
  return ObjC.unwrap($(path).stringByStandardizingPath)
}

// join :: (...string) -> string
function join(...paths) {
  if (!paths.length) return ''

  return ObjC.unwrap(
    paths.slice(1).reduce((acc, path) =>
      acc.stringByAppendingPathComponent(path).stringByStandardizingPath,
      $(paths[0]),
    )
  )
}

// dirname :: string -> string
function dirname(path) {
  return ObjC.unwrap(
    $(path).stringByStandardizingPath.stringByDeletingLastPathComponent,
  )
}

// basename :: string -> string
function basename(path, ext) {
  const name = ObjC.unwrap(
    $(path).stringByStandardizingPath.lastPathComponent,
  )
  return ext ? name.slice(0, ext.length) : name
}

// extname :: string -> string
function extname(path) {
  const ext = ObjC.unwrap(
    $(path).stringByStandardizingPath.pathExtension,
  )
  if (ext) return '.' + ext
  return path.endsWith('.') ? '.' : ''
}
