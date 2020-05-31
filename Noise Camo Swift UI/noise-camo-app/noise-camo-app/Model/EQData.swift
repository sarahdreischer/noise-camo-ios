//
//  EQData.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 10/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

class EQData: ObservableObject {
    @Published var gains = Array(repeating: 0.0, count: EqualizerSettings().frequencies.count)
}
