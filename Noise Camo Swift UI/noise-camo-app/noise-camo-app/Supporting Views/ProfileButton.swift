//
//  ProfileButton.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 10/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct ProfileButton: View {
    
    var destinationView: View
    
    var body: some View {
        HStack {
            NavigationLink(destination: destinationView) {
               Image(systemName: "person.circle")
                .font(.system(size: 30, weight: .regular))
                .padding(.trailing, 20)
                .foregroundColor(.white)
            }
        }
    }
}

struct ProfileButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButton(destinationView: HomeView())
    }
}
