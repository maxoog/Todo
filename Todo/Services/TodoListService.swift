//
//  TodoListService.swift
//  Todo
//
//  Created by Maksim Zenkov on 10.09.2024.
//

import Foundation


final class TodoListService {
    
    func fetchItems() async throws -> [TodoItem] {
        return [
            .init(id: .init(), text: "hello maaaan", tag: .home, status: .incomplete),
            .init(id: .init(), text: "Submit 2019 tax return", tag: .university, status: .incomplete),
            .init(id: .init(), text: "text", tag: .home, status: .completed),
            .init(id: .init(), text: "hello", tag: .work, status: .completed),
            .init(id: .init(), text: "this is a home task", tag: .university, status: .completed),
        ]
    }
    
}
