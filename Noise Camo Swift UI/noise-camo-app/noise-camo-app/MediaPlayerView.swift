//
//  MediaPlayerView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 16/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct MediaPlayerView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.4)
                Text("MediaPlayer").foregroundColor(.white)
            }
            .cornerRadius(20)
            .padding()
        }
    }
}

struct MediaPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MediaPlayerView()
    }
}
