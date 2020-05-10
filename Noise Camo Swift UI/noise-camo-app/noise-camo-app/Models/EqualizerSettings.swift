//
//  EqualizerSettings.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 10/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI
import AVFoundation

class EqualizerSettings: ObservableObject {
    let frequencies = [60, 150, 400, 1000, 2400, 15000]
    
    let gainsSettings = ["bass": [10.0, -10.0, -8.0, -10.0, -8.0, -8.0], "pop": [0.0, 4.0, 5.0, 6.0, 4.0, 0.0], "flat": [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]]
    
    @Published var audioEngine: AVAudioEngine = AVAudioEngine()

    @Published var audioPlayerNode: AVAudioPlayerNode = AVAudioPlayerNode()

    @Published var equalizer: AVAudioUnitEQ
        = AVAudioUnitEQ(numberOfBands: 6)
    
    @Published var audioFile: AVAudioFile!
    init() {
        do {
            if let filepath = Bundle.main.path(forResource: "song", ofType: "mp3") {
                
                let filepathURL = NSURL.fileURL(withPath: filepath)
                
                audioFile = try AVAudioFile(forReading: filepathURL)
            }
        } catch {
            print("Something went wrong when setting up the AudioFile")
        }
        
        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(equalizer)
        audioEngine.connect(audioPlayerNode, to: equalizer, format: nil)
        audioEngine.connect(equalizer, to: audioEngine.outputNode, format: nil)
    }
    
    func playEqualizedSong(_ play:Bool, gains:Array<Double>) {
        do {
            self.audioEngine.prepare()
            try self.audioEngine.start()
            self.audioPlayerNode.scheduleFile(self.audioFile, at: nil, completionHandler: nil)
            
            if play {
                self.audioPlayerNode.play()
            } else {
                self.audioPlayerNode.stop()
            }
        }
        catch _ {
            print("Something went wrong at equalization.")
        }
    }
}
