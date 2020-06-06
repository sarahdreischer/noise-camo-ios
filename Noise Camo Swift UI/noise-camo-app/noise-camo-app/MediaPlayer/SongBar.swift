//
//  SongBar.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 03/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct SongBar: View {
    @ObservedObject var songModel: SongViewModel
    private let screenWidth = UIScreen.main.bounds.width - 50

    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color.white.opacity(0.6))
                .frame(width: self.screenWidth, height: 8)
            Capsule()
                .fill(Color("top"))
                .frame(width: CGFloat(self.songModel.songBarWidthFactor) * screenWidth, height: 8)
        }
        .padding(.top)
        .onReceive(songModel.timer) { _ in
            self.songModel.checkIfSongFinished()
            self.songModel.updatePlayingTime()
            self.songModel.updateSongBarWidthFactor()
            
//            if !self.songModel.songs[self.songModel.currentSongIndex].finished && !self.songModel.songs[self.songModel.currentSongIndex].paused {
//                SongHelper.songFinished(songModel: self.songModel, audioService: self.audioService, playerModel: self.playerModel)
//                SongHelper.updatePlayingTime(songModel: self.songModel, audioService: self.audioService)
//                MediaPlayerHelper.updateSongBarWidthFactor(playerModel: self.playerModel, songModel: self.songModel, audioService: self.audioService)
//            }
        }
    }
}


//struct SongBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SongBar()
//    }
//}
