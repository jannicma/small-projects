import Foundation

func main() {
    // Get the path relative to the current file location
    let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        .appendingPathComponent("data1.txt")

    do {
        let content = try String(contentsOf: fileURL, encoding: .utf8)
        let lines: [String] = content.components(separatedBy: ",")
        let result = getInvalidIdSum(idRanges: lines)
        print("The sum of all invalid IDs is: \(result)")
    } catch {
        print("Error reading file: \(error)")
    }
}

func getInvalidIdSum(idRanges: [String]) -> Int {
    var invalidIdSum = 0

    for range in idRanges {
        let barriers = range.components(separatedBy: "-").compactMap { Int($0) }
        if barriers.count != 2 {
            print(range)
            continue
        }

        for i in barriers[0]...barriers[1] {
            let iString = String(i)
            if iString.count % 2 > 0 { continue }

            let idx = iString.index(iString.startIndex, offsetBy: iString.count / 2)
            let firstPart = iString[..<idx]
            let secondPart = iString[idx...]

            if firstPart == secondPart {
                print(i)
                invalidIdSum += i
            }
        }
    }

    return invalidIdSum
}

main()
