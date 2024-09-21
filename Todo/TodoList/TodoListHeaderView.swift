//
//  ItemStatusHeaderView.swift
//  Todo
//
//  Created by Maksim on 15.09.2024.
//

import Foundation
import UIKit

final class TodoListHeaderView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "March 9, 2020"
        label.font = .headline
        label.textColor = .contentTitle
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "5 incomplete, 5 completed"
        label.font = .contentSecondary
        label.textColor = .content
        return label
    }()
    
    lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 2)
        ])
        view.backgroundColor = .backgroundSecondary.withAlphaComponent(0.2)
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            separator
        ])
        stack.axis = .vertical
        stack.spacing = 8
        stack.setCustomSpacing(16, after: subtitleLabel)
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(stackView)
        stackView.pinEdgesToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with items: [TodoItem]) {
        UIView.animate(withDuration: 0.6) {
            let completedCount = items.filter({ $0.status == .completed }).count
            let incompleteCount = items.filter({ $0.status == .incomplete }).count
            self.subtitleLabel.text = self.subtitle(
                completed: completedCount,
                incomplete: incompleteCount
            )
        }
    }
    
    private func subtitle(completed: Int, incomplete: Int) -> String {
        "\(incomplete) incomplete, \(completed) completed"
    }
}

