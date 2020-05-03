//
//  EqualizerView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 03/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI
import AVFoundation

struct EqualizerView: View {
    
    @State private var equalizerValues = Array(repeating: 0.0, count: 5)
    
    @State private var celsius: Double = 0
    
    @State private var play = false

    @State private var audioEngine: AVAudioEngine = AVAudioEngine()

    @State private var audioPlayerNode: AVAudioPlayerNode = AVAudioPlayerNode()
    @State private var equalizer: AVAudioUnitEQ = AVAudioUnitEQ(numberOfBands: 5)
    @State private var audioFile: AVAudioFile!
    
    var body: some View {
        VStack {
            Text("Equalizer").font(.title)
            VStack {
                Slider(value: $equalizerValues[0], in: -10...10, step: 1)
                Text("\(equalizerValues[0]) is the current value")
                
                Slider(value: $equalizerValues[1], in: -10...10, step: 1)
                Text("\(equalizerValues[1]) is the current value")
                
                Slider(value: $equalizerValues[2], in: -10...10, step: 1)
                Text("\(equalizerValues[2]) is the current value")
                
                Slider(value: $equalizerValues[3], in: -10...10, step: 1)
                Text("\(equalizerValues[3]) is the current value")
                
                Slider(value: $equalizerValues[4], in: -10...10, step: 1)
                Text("\(equalizerValues[4]) is the current value")
            }
            
            Spacer()
            
            Button(action: {
                self.play.toggle()
                
                self.setUpAudioFile(song: "song")
                
                EqualizerLogic(audioEngine: self.$audioEngine, audioPlayerNode: self.$audioPlayerNode, equalizer: self.$equalizer)
                    .startEqualizer(self.play, audioFile: self.audioFile, gains: self.equalizerValues)
            }) {
                Text("Apply settings + play")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)   
            }
            Spacer()
            
        }
    }
    
    func setUpAudioFile(song:String) {
        do {
            if let filepath = Bundle.main.path(forResource: song, ofType: "mp3") {
                
                let filepathURL = NSURL.fileURL(withPath: filepath)
                
                audioFile = try AVAudioFile(forReading: filepathURL)
            }
        } catch {
            print("Something went wrong when setting up the AudioFile")
        }
    }
}
    

struct EqualizerView_Previews: PreviewProvider {
    static var previews: some View {
        EqualizerView()
    }
}
