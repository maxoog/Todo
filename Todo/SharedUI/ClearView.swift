//
//  ClearView.swift
//  Todo
//
//  Created by Maksim on 22.09.2024.
//

import Foundation
import UIKit

final class ClearView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        
        if view === self {
            return nil
        }
        return view
    }
}
