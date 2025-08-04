//
//  Task.swift
//  TaskListApp
//
//  Created by Anderson on 13/07/25.
//

import Foundation

struct Task: Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool
}
