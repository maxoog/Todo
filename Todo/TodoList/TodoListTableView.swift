//
//  TodoListTableView.swift
//  Todo
//
//  Created by Maksim Zenkov on 10.09.2024.
//

import Foundation
import UIKit
import Combine

typealias TodoItemID = UUID
typealias TodoListTableDataSource = UITableViewDiffableDataSource<TodoItemStatus, TodoItem>

final class TodoListTableView: UITableView {
    private var cancellable: AnyCancellable?
    private let onTodoItemTap: (TodoItemID) -> Void
    
    private lazy var _dataSource: TodoListTableDataSource = {
        let dataSource = TodoListTableDataSource(tableView: self)
        { [weak self] tableView, indexPath, model in
            guard let self else {
                return nil
            }
            
            let cell = reuse(TodoItemTableCellView.self, indexPath)
            cell.configure(with: model, onTap: { [weak self] in
                self?.onTodoItemTap(model.id)
            })
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        
        return dataSource
    }()
    
    init(onTodoItemTap: @escaping (TodoItemID) -> Void) {
        self.onTodoItemTap = onTodoItemTap
        super.init(frame: .zero, style: .grouped)
        self.delegate = self
        self.dataSource = _dataSource
        self.separatorStyle = .none
        self.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0)
        self.register(TodoItemTableCellView.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with itemsResult: Result<[TodoItem], TodoError>) {
        switch itemsResult {
        case .success(let items):
            var snapshot = NSDiffableDataSourceSnapshot<TodoItemStatus, TodoItem>()
            snapshot.appendSections(TodoItemStatus.allCases)
            snapshot.appendItems(items.filter{ $0.status == .incomplete }, toSection: .incomplete)
            snapshot.appendItems(items.filter{ $0.status == .completed }, toSection: .completed)
            _dataSource.apply(snapshot)
        case .failure(let error):
            assertionFailure("something went wrong \(error)")
        }
    }
    
}

extension TodoListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        indexPath
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let status = section.toTodoStatus() else {
            assertionFailure("Unknown section number!")
            return nil
        }
        let headerView = TodoSectionLabelView()
        headerView.configure(status: status)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        46
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selection \(indexPath.row)")
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func reuse<T: UITableViewCell>(_ type: T.Type, _ indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension Int {
    fileprivate func toTodoStatus() -> TodoItemStatus? {
        switch self {
        case 0:
            .incomplete
        case 1:
            .completed
        default: nil
        }
    }
}

extension TodoItemStatus: CustomStringConvertible {
    var description: String {
        switch self {
        case .incomplete:
            "Incomplete"
        case .completed:
            "Completed"
        }
    }
}
