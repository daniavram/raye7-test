//
//  RoundedCornersView.swift
//  raye7-test
//
//  Created by Daniel Avram on 01/09/16.
//  Copyright © 2016 Daniel Avram. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornersView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
}
