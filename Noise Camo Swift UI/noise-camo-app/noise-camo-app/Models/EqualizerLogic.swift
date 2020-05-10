//
//  EqualizerLogic.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 03/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI
import AVFoundation

struct EqualizerLogic {
    func getShelf(_ gain:Double) -> AVAudioUnitEQFilterType {
        if gain<0 { return AVAudioUnitEQFilterType.lowShelf }
        return AVAudioUnitEQFilterType.highShelf
    }
    
    func setBands(bands: [AVAudioUnitEQFilterParameters], gains:Array<Double>) {
           for i in 0...(bands.count - 1) {
               bands[i].frequency  = Float(EqualizerSettings().frequencies[i])
               bands[i].bypass     = false
               bands[i].gain = Float(gains[0])
               bands[i].filterType = getShelf(gains[i])
           }
    }
}

