//
//  EQButton.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 10/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct EQButton: View {
    let buttonText: String
    
    var body: some View {
        Text(buttonText)
            .foregroundColor(.white)
            .fontWeight(.medium)
            .font(.custom("Avenir", size: 20))
            .frame(width: 100, height: 45)
            .background(Color.orange)
            .cornerRadius(20)
    }
}

struct EQButton_Previews: PreviewProvider {
    static var previews: some View {
        EQButton(buttonText: "bass")
    }
}
