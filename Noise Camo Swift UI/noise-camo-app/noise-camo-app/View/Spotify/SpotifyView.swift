//
//  SpotifyView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 12/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct SpotifyView: View {
    
    var body: some View {
        VStack {
            Text("Spotify").foregroundColor(.white)
        }
    }
}

struct SpotifyView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            SpotifyView()
        }
    }
}
