import Foundation

class Task {
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.isFinished = false
        self.created = Date.now
    }
    let id: UUID
    var name: String
    var isFinished: Bool
    var created: Date
}
