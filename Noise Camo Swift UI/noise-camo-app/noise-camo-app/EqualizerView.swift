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
    @EnvironmentObject var eqSettings: EqualizerSettings
    
    init() {
        UINavigationBar
            .appearance()
            .titleTextAttributes = [.foregroundColor: UIColor.white]
    }
        
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<self.eqSettings.currentGain.count) { index in
                    EQSlider(sliderValue: self.$eqSettings.currentGain[index], label: String(self.eqSettings.frequencies[index]) + "kHz")
                        .foregroundColor(.white)
                }
            }.frame(height: 300).padding(.top, 20)
            
            GridStack(value: EqualizerSettings().gainsSettings, columns: 3) { key, col in
                Button(action: {
                    self.eqSettings.currentGain = EqualizerSettings().gainsSettings[key]!
                }) {
                    EQButton(buttonText: key)
                }
            }.padding()
            
            Spacer()
        }
    }
}
    

struct EqualizerView_Previews: PreviewProvider {
    static let eqSettings = EqualizerSettings()
    static var previews: some View {
        TabView {
            EqualizerView()
                .environmentObject(eqSettings)
                .modifier(PageViewWrapper())
        }
    }
}
