//
//  PlayerViewModel.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 31/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation

class PlayerViewModel: ObservableObject {
    @Published var songBarWidthFactor: Double = 0
    @Published var timer = Timer.publish(every: 0.1, on: .main, in: .common)
}
