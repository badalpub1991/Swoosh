//
//  BASCustomButton.swift
//  Swoosh
//
//  Created by badal shah on 22/12/17.
//  Copyright © 2017 badal shah. All rights reserved.
//

import UIKit

@IBDesignable class BASCustomButton: UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor?   {
            didSet {
                self.layer.borderColor = borderColor?.cgColor
            }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
