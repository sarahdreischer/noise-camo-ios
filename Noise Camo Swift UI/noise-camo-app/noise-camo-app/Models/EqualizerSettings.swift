//
//  EqualizerSettings.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 10/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI
import AVFoundation

struct EqualizerSettings {
    let frequencies = [60, 150, 400, 1000, 2400, 15000]
    
    let gainsSettings = ["bass": [10.0, -10.0, -8.0, -10.0, -8.0, -8.0], "pop": [0.0, 4.0, 5.0, 6.0, 4.0, 0.0], "flat": [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]]
}
