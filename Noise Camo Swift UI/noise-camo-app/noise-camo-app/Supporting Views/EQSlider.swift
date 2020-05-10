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
        HStack {
            Text("-10dB")
            Slider(value: $sliderValue, in: -10...10, step: 1)
            Text("+10dB")
        }
    }
}

struct EQSlider_Previews: PreviewProvider {
    static var previews: some View {
        EQSlider(sliderValue: Binding.constant(1.0))
    }
}
