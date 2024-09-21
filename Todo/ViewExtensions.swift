//
//  ViewExtensions.swift
//  Todo
//
//  Created by Maksim on 11.09.2024.
//

import Foundation
import UIKit

extension UIView {
    public func wrapWith(insets: UIEdgeInsets) -> UIView {
        let wrapper = UIView()
        wrapper.addSubview(self)
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: insets.left),
            self.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -insets.right),
            self.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: insets.top),
            self.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: -insets.bottom)
        ])
        return wrapper
    }
}

extension UIView {
    public func pinEdgesToSuperview() {
        guard let superview else {
            assertionFailure("Cannot find superview!")
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }
    
    public func centerInSuperview() {
        guard let superview else {
            assertionFailure("Cannot find superview!")
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }
}
