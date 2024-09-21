//
//  TodoItemTableCellView.swift
//  Todo
//
//  Created by Maksim Zenkov on 10.09.2024.
//

import Foundation
import UIKit

final class TodoItemTableCellView: UITableViewCell {
    private var onTap: (() -> Void)?
    
    lazy var checkmarkImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "checkmark_icon")?.withRenderingMode(.alwaysTemplate))
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 12),
            image.heightAnchor.constraint(equalToConstant: 12)
        ])
        image.tintColor = .contentDark
        return image
    }()
    
    lazy var boxImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "box_icon")
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 24),
            image.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        image.addSubview(checkmarkImage)
        checkmarkImage.centerInSuperview()
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .content
        label.textColor = .content
        return label
    }()
    
    lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.font = .contentSecondary
        label.textColor = .contentSecondary
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var secondaryStack: UIView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, tagLabel])
        stack.spacing = 4
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()
    
    lazy var mainStack: UIView = {
        let stack = UIStackView(arrangedSubviews: [boxImage, secondaryStack])
        stack.spacing = 16
        stack.axis = .horizontal
        stack.alignment = .top
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Self.handleTap))
        addGestureRecognizer(tapGesture)
        selectionStyle = .blue
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        let mainStack = mainStack.wrapWith(insets: .init(top: 0, left: 16, bottom: 16, right: 16))
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: TodoItem, onTap: @escaping () -> Void) {
        titleLabel.text = item.text
        titleLabel.textColor = titleColor(for: item.status)
        
        tagLabel.text = item.tag.description
        tagLabel.isHidden = item.status == .completed
        
        self.checkmarkImage.isHidden = item.status == .incomplete
        self.checkmarkImage.layer.removeAllAnimations()
        
        if item.status == .completed {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 0.2
            animation.toValue = 1
            animation.duration = 0.4
            checkmarkImage.layer.add(animation, forKey: nil)
        }
        
        self.onTap = onTap
    }
    
    private func titleColor(for status: TodoItemStatus) -> UIColor {
        switch status {
        case .incomplete:
            .content
        case .completed:
            .contentSecondary
        }
    }
    
    @objc private func handleTap(recognizer: UITapGestureRecognizer)  {
        guard let onTap else {
            assertionFailure("Cell should have tap handler!")
            return
        }
        onTap()
    }
}
