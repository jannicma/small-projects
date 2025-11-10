import Foundation

class AppLoop {
    private var isRunning: Bool = true
    private let handler: TaskHandler = TaskHandler()

    public func startApp() {
        print("Welcome to your TODO List \nfully in the Terminal!")
        print("-----------------------------")
        print()
        printInstructions()
        startAppLoop()
    }

    private func startAppLoop() {
        while isRunning {
            printTasks()
            print("Enter: ")
            if let command = readLine() {
                handleCommand(command)
            } else {
                invalidCommand()
            }

            print()
            print()
        }
    }

    private func handleCommand(_ command: String) {
        let parts = command.components(separatedBy: " ")
        switch parts[0] {
        case "add":
            addTask(arguments: parts)
        case "edit":
            editTask(arguments: parts)
        case "comp":
            completeTask(arguments: parts)
        case "exit":
            exitApp()
        case "help":
            printInstructions()
        default:
            invalidCommand()
        }
    }

    private func addTask(arguments: [String]) {
        let taskName = arguments[1...].joined(separator: " ")
        handler.addTask(taskName: taskName)
    }

    private func editTask(arguments: [String]) {
        let taskId = Int(arguments[1])!
        let newName = arguments[2...].joined(separator: " ")
        handler.editTask(id: taskId, newName: newName)
    }

    private func completeTask(arguments: [String]) {
        let taskId = Int(arguments[1])!
        handler.completeTask(id: taskId)
    }

    private func exitApp() {
        isRunning = false
    }

    private func invalidCommand() {
        print("enter a valid command (options with \"help\")")
        print()
    }

    private func printInstructions() {
        print("How to use (open this help with \"help\"):")
        print("\tAdd new task => add task name here")
        print("\tEdit task => edit {taskNumber} new name here")
        print("\tComplete task => comp {taskNumber}")
        print("\tExit => exit")
        print()
    }

    private func printTasks() {
        let tasks = handler.getTasks()
        print("Your tasks (\(tasks.count)):")
        if tasks.count == 0 { print("Nothing left here - chase the next peak!") }
        for (key, _) in tasks.enumerated() {
            if tasks[key].isFinished { continue }
            let name = tasks[key].name
            print("\(key) - \(name)")
        }
        print()
    }
}
