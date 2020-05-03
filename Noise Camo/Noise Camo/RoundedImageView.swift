//
//  RoundedImageView.swift
//  Noise Camo
//
//  Created by Sarah Dreischer on 26/04/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 20.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
