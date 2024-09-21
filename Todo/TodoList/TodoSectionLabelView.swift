//
//  ItemStatusHeaderView.swift
//  Todo
//
//  Created by Maksim on 15.09.2024.
//

import Foundation
import UIKit

final class TodoSectionLabelView: UILabel {
    private let bottomPadding: CGFloat = 16
    
    func configure(status: TodoItemStatus) {
        text = status.description
        font = .headline2
        textColor = .content
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: bottomPadding, right: 16)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return .init(width: size.width, height: size.height + bottomPadding)
    }
}
