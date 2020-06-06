//
//  SongNavigator.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 03/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct SongNavigator: View {
    @ObservedObject var songModel: SongViewModel
    
    private let screenWidth = UIScreen.main.bounds.width - 50
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width / 5 - 50) {
            Button(action: {
                self.songModel.next(SongDirection.backward)
            }) {
                Image(systemName: "backward.fill")
                    .font(.title)
            }
            Button(action: {
                self.songModel.jumpTo(15, SongDirection.backward)
            }) {
                Image(systemName: "gobackward.15")
                    .font(.title)
            }
            
            Button(action: {
                if !self.songModel.songs[self.songModel.currentSongIndex].playing {
                    self.songModel.play()
                } else {
                    self.songModel.pause()
                }
            }) {
                Image(systemName: self.songModel.songs[self.songModel.currentSongIndex].playing ? "pause.fill" : "play.fill")
                    .font(.system(size: 50))
            }
            
            Button(action: {
                self.songModel.jumpTo(15, SongDirection.forward)
            }) {
                Image(systemName: "goforward.15")
                    .font(.title)
            }
            
            Button(action: {
                self.songModel.next(SongDirection.forward)
            }) {
                Image(systemName: "forward.fill")
                    .font(.title)
            }
        }
        .padding(.top, 25)
        .foregroundColor(.white)
    }
}


//struct SongNavigator_Previews: PreviewProvider {
//    static var previews: some View {
//        SongNavigator()
//    }
//}
