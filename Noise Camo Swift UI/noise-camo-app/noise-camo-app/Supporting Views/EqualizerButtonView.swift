//
//  EqualizerButtonView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 10/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct EqualizerButtonView: View {
    let buttonText: String
    
    var body: some View {
        Text(buttonText)
            .foregroundColor(.white)
            .fontWeight(.medium)
            .font(.custom("Avenir", size: 25))
            .frame(width: 90, height: 50)
            .background(Color.orange)
            .cornerRadius(20)
    }
}

struct EqualizerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EqualizerButtonView(buttonText: "bass")
    }
}
