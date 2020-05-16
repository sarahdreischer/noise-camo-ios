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
    
    @State private var play = false

    @EnvironmentObject var eqSettings: EqualizerSettings
    
    init() {
        UINavigationBar
            .appearance()
            .titleTextAttributes = [.foregroundColor: UIColor.white]
    }
        
    var body: some View {
        ZStack {
            BackgroundView()
            ZStack {
                Rectangle()
                .foregroundColor(.black)
                .opacity(0.4)
                
                VStack {
                    HStack {
                        ForEach(0..<customGains.count) { index in
                            EQSlider(sliderValue: self.$customGains[index], label: String(self.eqSettings.frequencies[index]) + "kHz")
                                .foregroundColor(.white)
                        }
                    }.frame(height: 300).padding(.top, 20)
                    
                    GridStack(value: EqualizerSettings().gainsSettings, columns: 3) { key, col in
                        Button(action: {
                            self.customGains = EqualizerSettings().gainsSettings[key]!
                        }) {
                            EQButton(buttonText: key)
                        }
                    }.padding()
                    
                    Spacer()
                    
    //                Button(action: {
    //                    self.play.toggle()
    //                    self.startEqualizer(self.play, gains: self.customGains)
    //                }) {
    //                    Text("play")
    //                        .foregroundColor(.white)
    //                        .padding([.trailing, .leading], 20)
    //                        .padding()
    //                        .background(Color.red)
    //                        .cornerRadius(15)
    //                }.padding()
                }
            }
            .cornerRadius(20)
            .padding()
        }
    }
    
    func startEqualizer(_ play:Bool, gains:Array<Double>) {
        self.eqSettings.setBands(bands: self.eqSettings.equalizer.bands, gains: self.customGains)
        
        self.eqSettings.playEqualizedSong(play, gains: gains)
    }
}
    

struct EqualizerView_Previews: PreviewProvider {
    static let eqSettings = EqualizerSettings()
    static var previews: some View {
        TabView {
            EqualizerView().environmentObject(eqSettings)
        }
    }
}
