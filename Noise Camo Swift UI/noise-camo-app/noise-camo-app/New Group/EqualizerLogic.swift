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
    
    @Binding var audioEngine: AVAudioEngine
    
    @Binding var audioPlayerNode: AVAudioPlayerNode
    
    @Binding var equalizer: AVAudioUnitEQ
    
    func startEqualizer(_ play:Bool, audioFile:AVAudioFile, gains:Array<Double>) {
            // Set up Equalizer settings
            self.audioEngine.attach(self.audioPlayerNode)
            self.audioEngine.attach(self.equalizer)
            
            let bands = equalizer.bands
            let freqs = [60, 230, 910, 4000, 14000]
            
            audioEngine.connect(audioPlayerNode, to: equalizer, format: nil)
            audioEngine.connect(equalizer, to: audioEngine.outputNode, format: nil)
            
            for i in 0...(bands.count - 1) {
                bands[i].frequency  = Float(freqs[i])
                bands[i].bypass     = false
                bands[i].filterType = .parametric
            }
            
        bands[0].gain = Float(gains[0])
        bands[0].filterType = self.getShelf(gains[0])
        bands[1].gain = Float(gains[1])
            bands[1].filterType = self.getShelf(gains[1])
        bands[2].gain = Float(gains[2])
            bands[2].filterType = self.getShelf(gains[2])
        bands[3].gain = Float(gains[3])
            bands[3].filterType = self.getShelf(gains[3])
        bands[4].gain = Float(gains[4])
            bands[4].filterType = self.getShelf(gains[4])
            
        do {
            audioEngine.prepare()
                
            try self.audioEngine.start()
            
            audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
            
            if play {
                audioPlayerNode.play()
            } else {
                audioPlayerNode.stop()
            }
        }
        catch _ {
            print("Something went wrong at equalization.")
        }
    }
    
    private func getShelf(_ gain:Double) -> AVAudioUnitEQFilterType {
        if gain<0 { return AVAudioUnitEQFilterType.lowShelf }
        return AVAudioUnitEQFilterType.highShelf
        
    }
}

