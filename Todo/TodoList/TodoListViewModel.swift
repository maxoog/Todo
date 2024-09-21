//
//  TodoListViewModel.swift
//  Todo
//
//  Created by Maksim Zenkov on 10.09.2024.
//

import Foundation
import Combine

enum TodoError: Error {
    case unknown
}

final class TodoListViewModel {
    private let itemList = CurrentValueSubject<[TodoItem], TodoError>([])
    private let service: TodoListService
    
    var itemsListPublisher: AnyPublisher<[TodoItem], TodoError> {
        itemList.eraseToAnyPublisher()
    }
    
    init(listService: TodoListService) {
        self.service = listService
    }
    
    func loadList() async {
        do {
            let items = try await service.fetchItems()
            itemList.send(items)
        } catch {
            itemList.send(completion: .failure(.unknown))
        }
    }
    
    func onTodoItemTap(id: TodoItemID) {
        var newValue = itemList.value
        
        guard let index = newValue.firstIndex(where: { $0.id == id }) else {
            assertionFailure("Wrong tapped cell index!")
            return
        }
        
        newValue[index].status.toggle()
        itemList.send(newValue)
    }
}
