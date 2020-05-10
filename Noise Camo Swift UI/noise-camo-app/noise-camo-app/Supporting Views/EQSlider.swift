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
    
    var body: some View {
        VStack {
            Text("-10dB")
            GeometryReader { geometry in
                HStack {
                    Slider(value: self.$sliderValue, in: -10...10, step: 1)
                        .accentColor(.orange)
                        .rotationEffect(.degrees(-90), anchor: .center)
                        .frame(width: geometry.size.height, height: geometry.size.width)
                }
            }
            Text("+10dB")
        }
    }
}

struct EQSlider_Previews: PreviewProvider {
    static var previews: some View {
        EQSlider(sliderValue: Binding.constant(1.0))
    }
}
