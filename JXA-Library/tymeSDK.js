/**
 * https://www.tyme-app.com/en/scripting/
 */

const app = Application("Tyme")

// getApp :: () -> Application
function getApp() {
  return app
}

// findCategory :: ({ name: string }) -> Reference Category
function findCategory(info) {
  return app.categories.whose({ name: info.name })().flat()[0]
}

// findProject :: ({ name: string, cateName?: string }) -> Reference Project
function findProject(info) {
  const cate = info.cateName && findCategory({ name: info.cateName })
  return app.projects.whose(
    Object.assign(
      { name: info.name },
      cate && { categoryid: cate.id() },
    ),
  )().flat()[0]
}

// findTask :: ({ cateName?: string, projName?: string, name: string, taskType?: string }) -> Reference Task
function findTask(info) {
  const needProject = info.projName != null
  const proj = info.projName && findProject({ name: info.projName, cateName: info.cateName })
  const query = Object.assign(
    { name: info.name },
    info.taskType && { tasktype: info.taskType },
  )

  if (needProject) {
    if (!proj) return null

    return proj.tasks.whose(query)().flat()[0]
  }

  return app.projects.tasks.whose(query)().flat()[0]
}

// ensureCategory :: ({ name: string }) -> Reference Category
function ensureCategory(info) {
  let cate = findCategory(info)

  if (!cate) {
    cate = app.Category(info)
    cate.make()
  }

  return cate
}

// ensureProject :: ({ name: string, cateName?: string }) -> Reference Project
function ensureProject(info) {
  let proj = findProject(info)

  if (!proj) {
    proj = app.Project(info)
    proj.make()
  }

  return proj
}

// ensureTask :: ({ name: string, projName: string, cateName?: string, taskType?: string }) -> Reference Task
function ensureTask(info) {
  let task = findTask(info)

  if (!task) {
    const proj = ensureProject({ ...info, name: info.projName })
    task = app.Task({
      ...info,
      tasktype: info.taskType ?? 'timed',
    })
    proj.tasks.unshift(task)
  }

  return task
}

// runningTasks :: () -> Task[]
function runningTasks() {
  const ids = app.trackedtaskids()

  if (ids.length < 1) return []

  if (ids.length < 2) {
    return app.projects.tasks.whose({ id: ids[0] })().flat()
  }

  return app.projects.tasks.whose({
    _or: ids.map(id => ({ id })),
  })().flat()
}

// taskIsRunning :: Task -> boolean
function taskIsRunning(task) {
  return app.trackedtaskids().includes(task.id())
}

// startTask :: Task -> void
function startTask(task) {
  app.starttrackerfortaskid(task.id())
}

// stopTask :: Task -> void
function stopTask(task) {
  if (taskIsRunning(task)) {
    app.stoptrackerfortaskid(task.id())
  }
}

// restartTask :: Task -> void
function restartTask(task) {
  stopTask(task)
  startTask(task)
}

// switchTask :: Task -> void
function switchToTask(task) {
  runningTasks().forEach(stopTask)
  startTask(task)
}
