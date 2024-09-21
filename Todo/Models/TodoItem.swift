//
//  TodoItem.swift
//  Todo
//
//  Created by Maksim Zenkov on 10.09.2024.
//

import Foundation

enum TodoItemStatus: Hashable, CaseIterable {
    case incomplete
    case completed
    
    mutating func toggle() {
        switch self {
        case .incomplete:
            self = .completed
        case .completed:
            self = .incomplete
        }
    }
}

enum TodoItemTag: Hashable, CustomStringConvertible {
    case home
    case university
    case work
    
    var description: String {
        return "💰 Finance"
        
        switch self {
        case .home:
            "Home"
        case .university:
            "University"
        case .work:
            "Work"
        }
    }
}

struct TodoItem: Hashable {
    let id: UUID
    let text: String
    let tag: TodoItemTag
    var status: TodoItemStatus
}
