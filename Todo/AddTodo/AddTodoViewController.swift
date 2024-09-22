//
//  AddTodoViewController.swift
//  Todo
//
//  Created by Maksim on 21.09.2024.
//

import Foundation
import UIKit

final class AddTodoViewController: UIViewController {
    private var textViewHeightConstraint: NSLayoutConstraint? = nil
    
    lazy var textInputView: TextInputView = {
        return TextInputView(onPreferredHeightUpdated: onTextViewHeightUpdated)
    }()
    
    lazy var createTodoButtonView: UIButton = {
        let view = TodoButtonView(
            iconName: "arrow_up_icon",
            size: 32
        ) {
            
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .custom {  _ in
                    108
                }
            ]
            presentationController.prefersGrabberVisible = true
        }
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(textInputView)
        view.addSubview(createTodoButtonView)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        textViewHeightConstraint = textInputView.heightAnchor.constraint(equalToConstant: 24)
        
        NSLayoutConstraint.activate([
            textInputView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            textInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textViewHeightConstraint,
            
            // create todo item button config
            
            createTodoButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createTodoButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ].compactMap({ $0 }))
    }
     
    private func onTextViewHeightUpdated(_ newHeight: CGFloat) {
        
    }
}
