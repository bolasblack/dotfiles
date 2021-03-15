const path = Library('c4/path.js')
const fs = Library('c4/fs.js')

// require :: string -> any
function require(request) {
  const modulePath = require.resolve(request)

  if (!require.cache[modulePath]) {
    const contents = fs.readFileSync(modulePath)
    const module = new Module(modulePath)
    const __dirname = path.dirname(modulePath)
    const __filename = path.basename(modulePath)
	  
	  // https://github.com/nodejs/node/blob/853086fbaa9ca7c698c891fe32a3a42c985e743d/lib/internal/modules/cjs/loader.js#L201
    const moduleFactory = eval(`(function(exports, require, module, __filename, __dirname) {${contents}})`)
    moduleFactory(module.exports, require, module, __filename, __dirname)
    require.cache[modulePath] = module
  }

  const module = require.cache[modulePath]
  return module.exports
}

require.cache = {}

// resolveModulePath :: string -> string
require.resolve = function resolveModulePath(request, options = {}) {
  const resolvePaths = options.paths ?? ['']

  const suffix = ['', '.js', '/index.js'].find(s =>
    fs.existsSync(path.normalize(request + s)),
  )
  if (!suffix) throw createNotFoundError(request)
  return request + suffix

  function createNotFoundError(request) {
    const err = new Error(`Cannot find module '${request}'`)
    err.code = 'MODULE_NOT_FOUND'
    return err
  }
}

class Module {
  constructor(id = '', parent) {
    this.id = id
    this.exports = {}
    this.parent = parent
  }
}
