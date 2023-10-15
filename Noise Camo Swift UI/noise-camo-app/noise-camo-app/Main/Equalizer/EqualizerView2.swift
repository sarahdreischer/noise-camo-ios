//
//  EqualizerView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 27/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct EqualizerView2: View {
    
    @State var slider1: Float = 0.6
    @State var slider2: Float = 0.4
    @State var slider3: Float = 0.7
    @State var slider4: Float = 0.2
    @State var slider5: Float = 0.1
    @State var slider6: Float = 0.4
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                TitleView(title: "Equalizer")
                
                Spacer()
                
                equalizerSlider
                
                Spacer()
                
                bassBooster
                
                Spacer()
            }
        }
    }
}

struct EqualizerView2_Previews: PreviewProvider {
    static var previews: some View {
        EqualizerView2()
    }
}

private extension EqualizerView2 {
    var equalizerSlider: some View {
        HStack {
            SingleSliderView(currentValue: $slider1, label: "60kHz")
            
            SingleSliderView(currentValue: $slider2, label: "150kHz")
            
            SingleSliderView(currentValue: $slider3, label: "400kHz")
            
            SingleSliderView(currentValue: $slider4, label: "1000kHz")
            
            SingleSliderView(currentValue: $slider5, label: "2400kHz")
            
            SingleSliderView(currentValue: $slider6, label: "15000kHz")
        }
    }
    
    var bassBooster: some View {
        VStack {
            Text("Bass Booster").foregroundColor(.white)
        }.frame(height: 300)
    }
}
