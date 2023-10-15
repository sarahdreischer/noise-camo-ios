//
//  PlayerState.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 18/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation

struct PlayerStates: Identifiable {
    var id: UUID = UUID()
    var playing: Bool = false
    var paused: Bool = false
    var finished: Bool = false
}
