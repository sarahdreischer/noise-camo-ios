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
                    EQSlider(sliderValue: self.$eqService.currentGain[index], label: String(EqualizerData().frequencies[index]) + "kHz")
                        .foregroundColor(.white)
                }
            }.frame(height: 300)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
            GridStack(value: EqualizerData().gainsSettings, columns: 3) { key, col in
                Button(action: {
                    self.eqService.currentGain = EqualizerData().gainsSettings[key]!
                }) {
                    EQButton(buttonText: key)
                }
            }.padding(.horizontal, 30)
            
            Spacer()
            
        }
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

struct EQSlider: View {
    @Binding var sliderValue: Double
    
    let label: String
    
    var body: some View {
        VStack {
            Text("-10dB")
            GeometryReader { geometry in
                HStack {
                    Slider(value: self.$sliderValue, in: -10...10, step: 1)
                        .accentColor(Color("background"))
                        .rotationEffect(.degrees(-90), anchor: .center)
                        .frame(width: geometry.size.height, height: geometry.size.width)
                }
            }
            Text("+10dB")
            Text(label)
                .foregroundColor(.gray)
        }.font(.custom("Avenir", size: 10))
    }
}

extension View {
    func inExpandingRectangle() -> some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
            self
        }
    }
}

struct EQButton: View {
    let buttonText: String
    
    var body: some View {
        Text(buttonText)
            .foregroundColor(.white)
            .fontWeight(.medium)
            .font(.custom("Avenir", size: 15))
            .inExpandingRectangle()
            .frame(height: 35)
            .fixedSize(horizontal: false, vertical: true)
            .background(Color("background"))
            .cornerRadius(5)
    }
}
