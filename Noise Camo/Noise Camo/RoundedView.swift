//
//  RoundedView.swift
//  Noise Camo
//
//  Created by Sarah Dreischer on 26/04/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import UIKit

class RoundedView: UIView {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
