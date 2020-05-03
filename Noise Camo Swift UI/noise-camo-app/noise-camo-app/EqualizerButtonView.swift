//
//  EqualizerButtonView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 03/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct EqualizerButtonView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .cornerRadius(15)
                
                VStack{
                    HStack {
                        Text("equalizer")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(5)
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(15)
                            .padding([.top, .leading], 20)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct EqualizerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EqualizerButtonView()
    }
}
