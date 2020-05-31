//
//  EqualizerService.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 23/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI
import AVFoundation

class EqualizerService: ObservableObject {
    @Published var currentGain: Array<Double>
    
    @Published var equalizer: AVAudioUnitEQ
    
    init() {
        currentGain = Array(repeating: 0.0, count: EqualizerData().frequencies.count)  
        equalizer = AVAudioUnitEQ(numberOfBands: EqualizerData().frequencies.count)
    }
    
    func getShelf(_ gain:Double) -> AVAudioUnitEQFilterType {
        if gain<0 { return AVAudioUnitEQFilterType.lowShelf }
        return AVAudioUnitEQFilterType.highShelf
    }
    
    func setBands(bands: [AVAudioUnitEQFilterParameters]) {
           for i in 0...(bands.count - 1) {
            bands[i].frequency  = Float(EqualizerData().frequencies[i])
               bands[i].bypass     = false
               bands[i].gain = Float(currentGain[0])
               bands[i].filterType = getShelf(currentGain[i])
           }
    }
}
