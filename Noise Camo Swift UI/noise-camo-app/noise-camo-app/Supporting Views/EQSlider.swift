//
//  EQSlider.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 10/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct EQSlider: View {
    @Binding var sliderValue: Double
    
    let label: String
    
    var body: some View {
        VStack {
            Text("-10dB")
            GeometryReader { geometry in
                HStack {
                    Slider(value: self.$sliderValue, in: -10...10, step: 1)
                        .accentColor(Color("top"))
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

struct EQSlider_Previews: PreviewProvider {
    static var previews: some View {
        EQSlider(sliderValue: Binding.constant(1.0), label: "5kHz")
    }
}
