//
//  EqualizerButton.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 16/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct EqualizerButton: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                
                VStack {
                    HStack(alignment: .center) {
                        Text("equalizer")
                            .font(.custom("Avenir", size: 30))
                            .foregroundColor(.black)
                            .cornerRadius(15)
                    }
                }
            }
        }
    }
}

struct EqualizerButton_Previews: PreviewProvider {
    static var previews: some View {
        EqualizerButton()
    }
}
