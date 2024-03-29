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
    @EnvironmentObject var eqService: EqualizerService
        
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<self.eqService.currentGain.count) { index in
                    EqualizerSliderView(sliderValue: self.$eqService.currentGain[index], label: String(EqualizerData().frequencies[index]) + "kHz")
                        .foregroundColor(.white)
                }
            }.frame(height: 300)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
            GridStack(value: EqualizerData().gainsSettings, columns: 3) { key, col in
                Button(action: {
                    self.eqService.currentGain = EqualizerData().gainsSettings[key]!
                }) {
                    EqualizerButtonView(buttonText: key)
                }
            }.padding(.horizontal, 30)
            
            Spacer()
        }.padding(.top, 20)
    }
}
    

struct EqualizerView_Previews: PreviewProvider {
    static let eqSettings = EqualizerService()
    static var previews: some View {
        ZStack {
            BackgroundView()
            EqualizerView()
                .environmentObject(eqSettings)
        }
    }
}
