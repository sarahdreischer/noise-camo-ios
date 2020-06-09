//
//  BatteryView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 07/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct BatteryView: View {
    var body: some View {
        HStack(alignment: .center,spacing: 25) {
            Image(systemName: "headphones")
                .font(.system(size: 60,
                              weight: .thin))
                .foregroundColor(.white)
                .brightness(0.1)
                .padding(.top, -15)
            
            VStack(alignment: .leading) {
                Image(systemName: "battery.25")
                    .font(.system(size: 25,
                                  weight: .thin))
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                Text("25%")
                    .font(.system(size: 20,
                                  weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .padding()
        .frame(height: UIScreen.main.bounds.height/8)
        .background(Color.black.opacity(0.6))
        .cornerRadius(8)
    }
}

struct BatteryView_Previews: PreviewProvider {
    static var previews: some View {
        BatteryView()
    }
}
