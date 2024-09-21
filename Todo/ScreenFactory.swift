//
//  ScreenFactory.swift
//  Todo
//
//  Created by Maksim Zenkov on 10.09.2024.
//

import Foundation

@MainActor
final class ScreenFactory {
    private let appFactory = AppFactory.shared
    
    func todoListView() -> TodoListViewController {
        TodoListViewController(viewModel: appFactory.todoListViewModel())
    }
}

@MainActor
fileprivate final class AppFactory {
    static let shared = AppFactory()
    
    func todoListViewModel() -> TodoListViewModel {
        TodoListViewModel(listService: TodoListService())
    }
}
