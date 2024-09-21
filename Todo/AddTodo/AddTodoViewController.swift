//
//  AddTodoViewController.swift
//  Todo
//
//  Created by Maksim on 21.09.2024.
//

import Foundation
import UIKit

final class AddTodoViewController: UIViewController {
    lazy var textInputView = {
        let view = UITextField()
//        view.
        return view
    }()
    
    
    override func viewDidLoad() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .custom {  _ in
                    200
                }
            ]
            presentationController.prefersGrabberVisible = true
        }
        
        setupView()
    }
    
    private func setupView() {
        
    }
}
