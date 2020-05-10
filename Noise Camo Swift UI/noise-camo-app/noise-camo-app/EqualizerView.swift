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
        
    var body: some View {
        
        ZStack {
            Rectangle()
               .foregroundColor(.black)
               .edgesIgnoringSafeArea(.all)
            

            VStack {
                Text("Equalizer").font(.title).foregroundColor(Color.white)
                ForEach(0..<customGains.count) { index in
                    VStack {
                        EQSlider(sliderValue: self.$customGains[index])
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
                    self.startEqualizer(self.play, gains: self.customGains)
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
    
    func startEqualizer(_ play:Bool, gains:Array<Double>) {
        EqualizerLogic().setBands(bands: self.eqSettings.equalizer.bands, gains: self.customGains)
        
        self.eqSettings.playEqualizedSong(play, gains: gains)
    }
}
    

struct EqualizerView_Previews: PreviewProvider {
    static let eqSettings = EqualizerSettings()
    static var previews: some View {
        EqualizerView().environmentObject(eqSettings)
    }
}
