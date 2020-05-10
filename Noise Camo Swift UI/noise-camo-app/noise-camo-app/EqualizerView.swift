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
    
    @State private var customGains
        = Array(repeating: 0.0, count: EqualizerSettings().frequencies.count)
    
    @State private var celsius: Double = 0
    
    @State private var play = false

    @State private var audioEngine: AVAudioEngine = AVAudioEngine()

    @State private var audioPlayerNode: AVAudioPlayerNode = AVAudioPlayerNode()

    @State private var equalizer: AVAudioUnitEQ
        = AVAudioUnitEQ(numberOfBands: EqualizerSettings().frequencies.count)
    
    @State private var audioFile: AVAudioFile!
        
    var body: some View {
        
        ZStack {
            Rectangle()
               .foregroundColor(.black)
               .edgesIgnoringSafeArea(.all)
            

            VStack {
                Text("Equalizer").font(.title).foregroundColor(Color.white)
                ForEach(0..<customGains.count) { index in
                    VStack {
                        Slider(value: self.$customGains[index], in: -10...10, step: 1)
                        Text("\(self.customGains[index]) is the current value")
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                HStack {
                    
                    ForEach(EqualizerSettings().gainsSettings.keys.sorted(), id: \.self) { key in
                        Button(action: {
                            self.customGains = EqualizerSettings().gainsSettings[key]!
                            }) {
                                Text(key)
                                    .foregroundColor(.white)
                                    .fontWeight(.medium)
                                    .font(.custom("Avenir", size: 25))
                                    .padding([.leading, .trailing], 20)
                                    .padding([.top, .bottom], 5)
                                    .background(Color.gray)
                                    .cornerRadius(15)
                            }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    self.play.toggle()
                    
                    // TODO - Replace later with audio player
                    self.setUpAudioFile(song: "song")
                    
                    EqualizerLogic(
                        audioEngine: self.$audioEngine,
                        audioPlayerNode: self.$audioPlayerNode,
                        equalizer: self.$equalizer)
                        .startEqualizer(self.play, audioFile: self.audioFile, gains: self.customGains)
                }) {
                    Text("Apply settings + play")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                }.padding()
                
                
                Spacer()
                
            }
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
