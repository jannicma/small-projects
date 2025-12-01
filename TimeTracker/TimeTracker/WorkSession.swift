//
//  WorkSession.swift
//  TimeTracker
//
//  Created by Jannic Marcon on 28.11.2025.
//

import Foundation
import SwiftData

@Model
final class WorkSession {
    var notes: String?
    var start: Date
    var end: Date?
    var tags: [Tag]
    
    init(start: Date) {
        self.notes = nil
        self.start = start
        self.end = nil
        self.tags = []
    }
}
