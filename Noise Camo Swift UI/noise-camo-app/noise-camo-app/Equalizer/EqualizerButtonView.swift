//
//  EqualizerButtonView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 10/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

extension View {
    func inExpandingRectangle() -> some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
            self
        }
    }
}

struct EqualizerButtonView: View {
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

struct EqualizerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EqualizerButtonView(buttonText: "bass")
    }
}
