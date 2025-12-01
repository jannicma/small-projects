//
//  Item.swift
//  TimeTracker
//
//  Created by Jannic Marcon on 28.11.2025.
//

import Foundation
import SwiftData

@Model
final class Tag {
    var name: String
    @Relationship(inverse: \WorkSession.tags) var workSessions: [WorkSession]
    
    init(name: String) {
        self.name = name
        self.workSessions = []
    }
}
