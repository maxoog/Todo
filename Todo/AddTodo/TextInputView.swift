//
//  TextInputView.swift
//  Todo
//
//  Created by Maksim on 22.09.2024.
//

import Foundation
import UIKit


final class TextInputView: UITextView {
    let onPreferredHeightUpdated: (CGFloat) -> Void
    
    lazy var placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Type your task here"
        placeholderLabel.numberOfLines = 1
        placeholderLabel.font = .content
        placeholderLabel.textColor = .contentSecondary
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return placeholderLabel
    }()
    
    init(onPreferredHeightUpdated: @escaping (CGFloat) -> Void) {
        self.onPreferredHeightUpdated = onPreferredHeightUpdated
        super.init(frame: .zero, textContainer: nil)
        
        font = .content
        tintColor = .content
        textColor = .content
        backgroundColor = .clear
        delegate = self
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            placeholderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let newHeight = sizeThatFits( .init(width: frame.size.width, height: .infinity)).height
        onPreferredHeightUpdated(newHeight)
    }
}

extension TextInputView: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty || textView.isFirstResponder
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = true
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty || textView.isFirstResponder
    }
}
