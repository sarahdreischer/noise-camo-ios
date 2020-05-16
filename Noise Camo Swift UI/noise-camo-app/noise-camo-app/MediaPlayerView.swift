//
//  MediaPlayerView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 16/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct MediaPlayerView: View {
    @State private var play = false
    
    @EnvironmentObject var eqSettings: EqualizerSettings
    
    var body: some View {
        ZStack {
            BackgroundView()
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.4)
                VStack {
                    Text("MediaPlayer").foregroundColor(.white)
                    
                    Button(action: {
                        self.play.toggle()
                        
                        self.eqSettings.playEqualizedSong(self.play)
                    }) {
                        Text("play")
                            .foregroundColor(.white)
                            .padding([.trailing, .leading], 20)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(15)
                    }.padding()
                }
            }
            .cornerRadius(20)
            .padding()
        }
    }
}

struct MediaPlayerView_Previews: PreviewProvider {
    static let eqSettings = EqualizerSettings()
    static var previews: some View {
        MediaPlayerView().environmentObject(eqSettings)
    }
}
