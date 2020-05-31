//
//  MediaPlayerView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 16/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI
import AVKit

struct MediaPlayer: View {
    
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
            
            ArtistInfo(songModel: self.songModel)
            
            SongBar(songModel: self.songModel, playerModel: self.playerModel)
            
            SongNavigator(songModel: self.songModel, playerModel: self.playerModel)
            
            Spacer()
         
        }
        .scaleEffect(0.9)
        .onAppear {
            self.eqService.setBands(bands: self.eqService.equalizer.bands)
            self.audioService.attachEqualizer(equalizer: self.eqService.equalizer)
            self.audioService.prepareToPlay(audioFile: self.songModel.songs[self.songModel.currentSongIndex].audioFile!)
        }
    }
}

struct MediaPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            MediaPlayer()
                .environmentObject(AudioService())
                .environmentObject(EqualizerService())
        }
    }
}

struct ArtistInfo: View {
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
//    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common)

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
            if !self.songModel.songs[self.songModel.currentSongIndex].finished {
                PlayerHelper.updateSongBarWidthFactor(playerModel: self.playerModel, songModel: self.songModel, audioService: self.audioService)
            }
            SongHelper.songFinished(songModel: self.songModel, audioService: self.audioService, playerModel: self.playerModel)
        }
//        .onReceive(self.timer) { _ in
//            self.audioService.updateBarWidth(maxBarWidth: self.screenWidth)
//
//            print(self.audioService.finished)
//            self.audioService.finished = (self.audioService.audioPlayerNode.currentTime + self.audioService.songTimeAdjustment >= self.audioService.getActualSongDuration())
//        }
//        .onReceive(self.songModel.songs[self.songModel.currentSongIndex]) { paused in
//            if paused {
//                self.cancelTimer()
//                self.audioService.songBarWidth = self.audioService.barWidthAtPause
//            }
//        }
//        .onReceive(self.audioService.$playing) { playing in
//            if playing {
//                self.instantiateTimer()
//                self.timer.connect()
//            }
//        }
//        .onReceive(self.audioService.$finished) { finished in
//            if finished {
//                self.audioService.songBarWidth = self.screenWidth
//                self.cancelTimer()
//            }
//        }
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
                SongHelper.changeSong(songModel: self.songModel, audioService: self.audioService, playerModel: self.playerModel)
            }) {
                Image(systemName: "backward.fill")
                    .font(.title)
            }
            Button(action: {
                let decrease = self.audioService.getActualSongTime(at: -15)
                let duration = self.audioService.getActualSongDuration(songFileLength: self.songModel.songs[self.songModel.currentSongIndex].length)
                self.audioService.audioPlayerNode.seekTo(
                    value: Float((decrease < 0) ? 0 : decrease),
                    audioFile: self.songModel.songs[self.songModel.currentSongIndex].audioFile!,
                    duration: Float(duration + self.audioService.songTimeAdjustment)
                )
                self.audioService.songTimeAdjustment = (decrease < 0) ? 0 : decrease
            }) {
                Image(systemName: "gobackward.15")
                    .font(.title)
            }
            
            Button(action: {
                if self.audioService.audioPlayerNode.isPlaying {
                    self.audioService.barWidthAtPause = CGFloat(self.playerModel.songBarWidthFactor)
                    self.audioService.audioPlayerNode.pause()
                    self.songModel.songs[self.songModel.currentSongIndex].paused = true
                    self.songModel.songs[self.songModel.currentSongIndex].playing = false
                } else {
                    if self.songModel.songs[self.songModel.currentSongIndex].finished == true {
                        SongHelper.changeSong(songModel: self.songModel, audioService: self.audioService, playerModel: self.playerModel)
                    } else {
                        self.songModel.songs[self.songModel.currentSongIndex].paused = false
                        
                        self.playerModel.timer.connect()
                        self.audioService.audioPlayerNode.play()
                        
                        self.songModel.songs[self.songModel.currentSongIndex].playing = true
                    }
                }
            }) {
                Image(systemName: self.audioService.audioPlayerNode.isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 50))
            }
            
            Button(action: {
                let increase = self.audioService.getActualSongTime(at: 15)
                let duration = self.audioService.getActualSongDuration(songFileLength: self.songModel.songs[self.songModel.currentSongIndex].length)
                self.audioService.audioPlayerNode.seekTo(
                    value: (increase < duration) ? Float(increase) : Float(duration),
                    audioFile: self.songModel.songs[self.songModel.currentSongIndex].audioFile!,
                    duration: Float(duration)
                )
                self.audioService.songTimeAdjustment += 15
            }) {
                Image(systemName: "goforward.15")
                    .font(.title)
            }
            
            Button(action: {
                SongHelper.changeSong(songModel: self.songModel, audioService: self.audioService, playerModel: self.playerModel)
            }) {
                Image(systemName: "forward.fill")
                    .font(.title)
            }
        }
        .padding(.top, 25)
        .foregroundColor(.white)
    }
}
