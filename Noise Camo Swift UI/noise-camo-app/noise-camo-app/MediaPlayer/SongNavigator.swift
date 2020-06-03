//
//  SongNavigator.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 03/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct SongNavigator: View {
    @EnvironmentObject var audioService: AudioService
    @ObservedObject var songModel: SongViewModel
    @ObservedObject var playerModel: PlayerViewModel
    
    private let screenWidth = UIScreen.main.bounds.width - 50
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width / 5 - 50) {
            Button(action: {
                SongHelper.changeSong(SongDirection.backward, songModel: self.songModel, audioService: self.audioService, playerModel: self.playerModel)
            }) {
                Image(systemName: "backward.fill")
                    .font(.title)
            }
            Button(action: {
                SongHelper.jumpTo(15, SongDirection.backward, songModel: self.songModel, audioService: self.audioService)
            }) {
                Image(systemName: "gobackward.15")
                    .font(.title)
            }
            
            Button(action: {
                SongHelper.playSong(songModel: self.songModel, audioService: self.audioService, playerModel: self.playerModel)
            }) {
                Image(systemName: self.songModel.songs[self.songModel.currentSongIndex].playing ? "pause.fill" : "play.fill")
                    .font(.system(size: 50))
            }
            
            Button(action: {
                SongHelper.jumpTo(15, SongDirection.forward, songModel: self.songModel, audioService: self.audioService)
            }) {
                Image(systemName: "goforward.15")
                    .font(.title)
            }
            
            Button(action: {
                SongHelper
                    .changeSong(SongDirection.forward, songModel: self.songModel, audioService: self.audioService, playerModel: self.playerModel)
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
