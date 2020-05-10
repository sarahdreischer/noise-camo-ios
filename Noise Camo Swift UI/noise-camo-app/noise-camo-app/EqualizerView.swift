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
        
        NavigationView {
        
            ZStack {
                Rectangle()
                   .foregroundColor(.black)
                   .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()
                    
                    HStack {
                        ForEach(0..<customGains.count) { index in
                            EQSlider(sliderValue: self.$customGains[index])
                                .foregroundColor(.white)
                        }
                    }.frame(height: 400)
                    
                    Spacer()
                    
                    HStack(spacing: 30) {
                        ForEach(EqualizerSettings().gainsSettings.keys.sorted(), id: \.self) { key in
                            Button(action: {
                                self.customGains = EqualizerSettings().gainsSettings[key]!
                                }) {
                                    EQButton(buttonText: key)
                                }
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.play.toggle()
                        self.startEqualizer(self.play, gains: self.customGains)
                    }) {
                        Text("play")
                            .foregroundColor(.white)
                            .padding([.trailing, .leading], 20)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(15)
                    }.padding()
                    
                    
                    Spacer()
                    
                }
            }
            .navigationBarTitle("Equalizer")
            .navigationBarItems(trailing:
                HStack {
                    NavigationLink(destination: EqualizerView()) {
                       Image(systemName: "person.circle")
                        .font(.system(size: 30, weight: .regular))
                        .padding(.trailing, 20)
                        .foregroundColor(.white)
                    }
                })
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
        EqualizerView().environmentObject(eqSettings)
    }
}
