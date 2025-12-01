import Foundation

func main() {
    // Get the path relative to the current file location
    let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        .appendingPathComponent("data1.txt")

    do {
        let content = try String(contentsOf: fileURL, encoding: .utf8)
        let lines: [String] = content.components(separatedBy: .newlines)
        let result = getPassword(commands: lines)
        print("The password to enter the north pole is: \(result)")
    } catch {
        print("Error reading file: \(error)")
    }
}

func getPassword(commands: [String]) -> Int {
    var position = 100_000_050
    var password = 0

    for command in commands {
        if command.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { break }
        if position < 0 { print("not good") }

        var cmd = command
        let direction = cmd.removeFirst()
        let mult = direction == "L" ? -1 : 1

        position += Int(cmd)! * mult
        print("direction: \(direction) - command: \(cmd) - position: \(position)")
        if position % 100 == 0 {
            print("HEREEEE")
            password += 1
        }
    }

    return password
}

main()
