//
//  EqualizerView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 27/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct EqualizerView2: View {
    
    @State var slider1: Float = 50
    @State var slider2: Float = 40
    @State var slider3: Float = 70
    @State var slider4: Float = 20
    @State var slider5: Float = 10
    @State var slider6: Float = 40
    
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
            SingleSliderView(percentage: $slider1, label: "60kHz")
            
            SingleSliderView(percentage: $slider2, label: "150kHz")
            
            SingleSliderView(percentage: $slider3, label: "400kHz")
            
            SingleSliderView(percentage: $slider4, label: "1000kHz")
            
            SingleSliderView(percentage: $slider5, label: "2400kHz")
            
            SingleSliderView(percentage: $slider6, label: "15000kHz")
        }
    }
    
    var bassBooster: some View {
        VStack {
            Text("Bass Booster").foregroundColor(.white)
        }.frame(height: 300)
    }
}
