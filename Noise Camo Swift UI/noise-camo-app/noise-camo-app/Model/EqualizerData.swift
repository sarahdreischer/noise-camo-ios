//
//  EqualizerData.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 23/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct EqualizerData {
    let frequencies = [60, 150, 400, 1000, 2400, 15000]
    
    let gainsSettings = [
        "bass": [10.0, -10.0, -8.0, -10.0, -8.0, -8.0],
        "pop": [0.0, 4.0, 5.0, 6.0, 4.0, 0.0],
        "flat": [0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        "set1": [1.0, 2.0, 3.0, 4.0, 5.0, 6.0],
        "set2": [6.0, 5.0, 4.0, 3.0, 2.0, 1.0],
        "set3": [-1.0, -2.0, -3.0, 3.0, 2.0, 1.0],
        "set4": [-1.0, -2.0, -3.0, 3.0, 2.0, 1.0],
        "set5": [-1.0, -2.0, -3.0, 3.0, 2.0, 1.0],
        "set6": [-1.0, -2.0, -3.0, 3.0, 2.0, 1.0]]
}
