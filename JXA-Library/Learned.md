## 一

JXA 写 Library 的时候，应该只导出函数，函数应该只返回基本数据结构和简单对象（比如 `{}`, `[]`, `Application` 等）。似乎 Library 没办法导出除了函数之外的内容，Library 和脚本代码好像不是直接通信的，可能会经过一次转换。

举个例子：

```javascript
// library
function findTasks(name) {
  return Application('Tyme').projects.tasks.whose({ name })
}

// scripts
var tyme = Library('c4/tymeSDK.js')

var a = [
  findTasks('test')[0],
  Application('Tyme').projects.tasks.whose({ name: 'test' })[0],
]
a
```

输出：

```javascript
[
  Application("Tyme").projects.tasks.whose({_match: [ObjectSpecifier().name, "test"]}).tasks.0,
  Application("Tyme").projects.tasks.whose({_match: [ObjectSpecifier().name, "test"]}).tasks.at(0)
]
```
