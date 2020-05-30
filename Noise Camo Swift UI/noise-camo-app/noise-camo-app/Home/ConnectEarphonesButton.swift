//
//  ConnectEarphonesButton.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 31/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct ConnectEarphonesButton: View {
    var body: some View {
        HStack {
            Image("bluetooth-3")
                .renderingMode(.original)
                .resizable()
                .frame(width: 40, height: 40)
                .shadow(radius: 10)
            
            Text("Connect Earphones")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .regular))
                .shadow(radius: 5)
        }
        .frame(width: UIScreen.main.bounds.width - 30,
               height: UIScreen.main.bounds.height / 15)
        .background(Color("gray"))
        .clipShape(Capsule())
    }
}

struct ConnectEarphonesButton_Previews: PreviewProvider {
    static var previews: some View {
        ConnectEarphonesButton()
    }
}
