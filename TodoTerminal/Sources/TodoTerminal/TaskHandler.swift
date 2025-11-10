import Foundation

class TaskHandler {
    private var tasks: [Task] = []
    init() {}

    public func getTasks() -> [Task] {
        return tasks
    }

    public func addTask(taskName: String) {
        let task = Task(name: taskName)
        tasks.append(task)
    }

    public func editTask(id: Int, newName: String) {
        tasks[id].name = newName
    }

    public func completeTask(id: Int) {
        tasks[id].isFinished = true
    }

}
