//
//  AddItemButtonView.swift
//  Todo
//
//  Created by Maksim on 15.09.2024.
//

import Foundation
import UIKit

final class TodoButtonView: UIButton {
    let iconName: String
    let size: CGFloat
    let onTap: () -> Void
    
    init(iconName: String, size: CGFloat, onTap: @escaping () -> Void) {
        self.iconName = iconName
        self.size = size
        self.onTap = onTap
        super.init(frame: .zero)
        
        let button = UIButton()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .accentColor
        layer.cornerRadius = size / 2
        setImage(UIImage(named: iconName), for: .normal)
        addTarget(self, action: #selector(handleTap), for: .touchDown)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: size),
            widthAnchor.constraint(equalToConstant: size)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleTap() {
        onTap()
    }
}

