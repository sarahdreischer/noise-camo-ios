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
                bands[i].gain = Float(gains[0])
                bands[i].filterType = self.getShelf(gains[i])
            }
            
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

