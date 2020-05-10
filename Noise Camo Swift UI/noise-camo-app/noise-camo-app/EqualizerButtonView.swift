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
                Image("earphone-background1")
                    .resizable()
                    .renderingMode(.original)
                    .cornerRadius(10)
                
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
            .frame(height: 300)
        }
    }
}

struct EqualizerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EqualizerButtonView()
    }
}
