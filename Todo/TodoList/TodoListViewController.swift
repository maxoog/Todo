//
//  ViewController.swift
//  Todo
//
//  Created by Maksim Zenkov on 10.09.2024.
//

import UIKit
import Combine

final class TodoListViewController: UIViewController {
    let tableView: TodoListTableView
    let headerView: TodoListHeaderView = TodoListHeaderView()
    let viewModel: TodoListViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: TodoListViewModel) {
        self.viewModel = viewModel
        self.tableView = TodoListTableView(onTodoItemTap: viewModel.onTodoItemTap)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeader()
        setupTable()
        setupAddItemButton()
        
        Task {
            await viewModel.loadList()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setupHeader() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupTable() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        viewModel.itemsListPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.tableView.update(with: .failure(error))
                }
            } receiveValue: { [weak self] todoItems in
                guard let self else {
                    return
                }
                self.headerView.update(with: todoItems)
                self.tableView.update(with: .success(todoItems))
            }.store(in: &cancellables)
    }
    
    private func setupAddItemButton() {
        let button = AddItemButtonView(onTap: onAddItemButtonTap)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func onAddItemButtonTap() {
        let viewController = AddTodoViewController()
        present(viewController, animated: true)
    }
}
