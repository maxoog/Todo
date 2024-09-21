//
//  AddItemButtonView.swift
//  Todo
//
//  Created by Maksim on 15.09.2024.
//

import Foundation
import UIKit

final class AddItemButtonView: UIView {
    let onTap: () -> Void
    
    init(onTap: @escaping () -> Void) {
        self.onTap = onTap
        super.init(frame: .zero)
        
        let button = UIButton()
        translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .accentColor
        button.layer.cornerRadius = 28
        button.setImage(UIImage(named: "plus_icon"), for: .normal)
        button.addTarget(self, action: #selector(handleTap), for: .touchDown)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 56),
            button.widthAnchor.constraint(equalToConstant: 56),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }
    
    @objc private func handleTap() {
        onTap()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        
        if view === self {
            return nil
        }
        return view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

