//
//  MediaPlayerView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 16/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI
import AVKit

struct MediaPlayerView: View {
    
    @EnvironmentObject var audioService: AudioService
    @EnvironmentObject var eqService: EqualizerService
    @ObservedObject var songModel = SongViewModel()
    @ObservedObject var playerModel = PlayerViewModel()
 
    private let screenWidth = UIScreen.main.bounds.width - 50
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            Image(uiImage: (self.songModel.songs[self.songModel.currentSongIndex].audioArtwork?.count == 0) ?
                UIImage(named: "itunes")! :
                UIImage(data: self.songModel.songs[self.songModel.currentSongIndex].audioArtwork!)!)
                .resizable()
                .frame(width: self.songModel.songs[self.songModel.currentSongIndex].audioArtwork?.count == 0 ? 250 : nil, height: 250)
                .cornerRadius(15)
            
            ArtistInfoView(songModel: self.songModel)
            
            SongBar(songModel: self.songModel, playerModel: self.playerModel)
            
            SongNavigator(songModel: self.songModel, playerModel: self.playerModel)
            
            Spacer()
         
        }
        .scaleEffect(0.9)
        .onAppear {
            self.eqService.setBands(bands: self.eqService.equalizer.bands)
            self.audioService.attachEqualizer(equalizer: self.eqService.equalizer)
        }
    }
}

struct MediaPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            MediaPlayerView()
                .environmentObject(AudioService())
                .environmentObject(EqualizerService())
        }
    }
}

struct ArtistInfoView: View {
    @ObservedObject var songModel: SongViewModel
    
    private let screenWidth = UIScreen.main.bounds.width - 50
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.songModel.songs[self.songModel.currentSongIndex].audioTitle!)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .padding(.top)
                Text(self.songModel.songs[self.songModel.currentSongIndex].audioArtist!)
                    .font(.system(size: 16))
                    .foregroundColor(Color("gray-1"))
                    .padding(.top)
            }.padding(.leading, 30)
            Spacer()
        }
    }
}

struct SongBar: View {
    @EnvironmentObject var audioService: AudioService
    @ObservedObject var songModel: SongViewModel
    @ObservedObject var playerModel: PlayerViewModel
    private let screenWidth = UIScreen.main.bounds.width - 50

    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color.white.opacity(0.6))
                .frame(width: self.screenWidth, height: 8)
            Capsule()
                .fill(Color("top"))
                .frame(width: CGFloat(self.playerModel.songBarWidthFactor) * screenWidth, height: 8)
        }
        .padding(.top)
        .onReceive(playerModel.timer) { _ in
            if !self.songModel.songs[self.songModel.currentSongIndex].finished && !self.songModel.songs[self.songModel.currentSongIndex].paused {
                SongHelper.songFinished(songModel: self.songModel, audioService: self.audioService, playerModel: self.playerModel)
                SongHelper.updatePlayingTime(songModel: self.songModel, audioService: self.audioService)
                PlayerHelper.updateSongBarWidthFactor(playerModel: self.playerModel, songModel: self.songModel, audioService: self.audioService)
            }
        }
    }
}

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
