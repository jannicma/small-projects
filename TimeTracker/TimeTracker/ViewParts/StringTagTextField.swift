//
//  StringTagTextField.swift
//  TimeTracker
//
//  Created by Jannic Marcon on 30.11.2025.
//

import SwiftUI
import SwiftData

struct TagsTextField: View {
    @Binding var tags: [Tag]
    @State private var text: String = ""

    var body: some View {
        TextField("#Tags", text: $text)
            .textFieldStyle(.roundedBorder)
            .onAppear {
                text = tags.map { $0.name }.joined(separator: " ")
            }
            .onChange(of: text) { _, newValue in
                let names = newValue
                    .split(whereSeparator: \.isWhitespace)
                    .map(String.init)

                var existingByName: [String: Tag] = [:]
                for tag in tags {
                    existingByName[tag.name] = tag
                }

                var newTags: [Tag] = []
                for name in names {
                    if let existing = existingByName[name] {
                        newTags.append(existing)
                    } else {
                        newTags.append(Tag(name: name))
                    }
                }

                if !areSameTags(lhs: tags, rhs: newTags) {
                    tags = newTags
                }
            }
            .onChange(of: tags) { _, newValue in
                let joined = newValue.map { $0.name }.joined(separator: " ")
                if joined != text {
                    text = joined
                }
            }
    }

    // Compare two tag arrays by name to avoid reference-equality issues
    private func areSameTags(lhs: [Tag], rhs: [Tag]) -> Bool {
        guard lhs.count == rhs.count else { return false }
        return zip(lhs, rhs).allSatisfy { $0.name == $1.name }
    }
}
