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
 
    private let screenWidth = UIScreen.main.bounds.width - 50
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            Image(uiImage: self.audioService.audioData.count == 0 ? UIImage(named: "itunes")! : UIImage(data: self.audioService.audioData)!)
                .resizable()
                .frame(width: self.audioService.audioData.count == 0 ? 250 : nil, height: 250)
                .cornerRadius(15)
            
            ArtistInfo()
            
            SongBar()
            
            SongNavigator()
            
            Spacer()
         
        }
        .scaleEffect(0.9)
        .onAppear {
            self.eqService.setBands(bands: self.eqService.equalizer.bands)
            self.audioService.attachEqualizer(equalizer: self.eqService.equalizer)
            self.audioService.setAudioFile(fileName: self.audioService.songs[self.audioService.currentSongIndex], fileType: "mp3")
            self.audioService.prepareToPlay()
            self.audioService.extractAudioData()
        }
    }
}

struct MediaPlayerView_Previews: PreviewProvider {
    static let audioService = AudioService()
    static let eqService = EqualizerService()
    static var previews: some View {
        ZStack {
            BackgroundView()
            MediaPlayerView()
                .environmentObject(audioService)
                .environmentObject(eqService)
        }
    }
}

struct ArtistInfo: View {
    @EnvironmentObject var audioService: AudioService
    
    private let screenWidth = UIScreen.main.bounds.width - 50
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.audioService.audioTitle)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .padding(.top)
                Text(self.audioService.audioArtist)
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
    
    private let screenWidth = UIScreen.main.bounds.width - 50
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common)

    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color.white.opacity(0.6))
                .frame(width: self.screenWidth, height: 8)
            Capsule()
                .fill(Color("top"))
                .frame(width: self.audioService.songBarWidth, height: 8)
        }
        .padding(.top)
        .onReceive(self.timer) { _ in
            self.audioService.updateBarWidth(maxBarWidth: self.screenWidth)
            
            print(self.audioService.finished)
            self.audioService.finished = (self.audioService.audioPlayerNode.currentTime + self.audioService.songTimeAdjustment >= self.audioService.getActualSongDuration())
        }
        .onReceive(self.audioService.$paused) { paused in
            if paused {
                self.cancelTimer()
                self.audioService.songBarWidth = self.audioService.barWidthAtPause
            }
        }
        .onReceive(self.audioService.$playing) { playing in
            if playing {
                self.instantiateTimer()
                self.timer.connect()
            }
        }
        .onReceive(self.audioService.$finished) { finished in
            if finished {
                self.audioService.songBarWidth = self.screenWidth
                self.cancelTimer()
            }
        }
    }
    
    func instantiateTimer() {
        self.timer = Timer.publish (every: 0.1, on: .main, in: .common)
        return
    }

    func cancelTimer() {
        self.timer.connect().cancel()
        return
    }
}

struct SongNavigator: View {
    @EnvironmentObject var audioService: AudioService
    
    private let screenWidth = UIScreen.main.bounds.width - 50
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width / 5 - 50) {
            Button(action: {
                if self.audioService.currentSongIndex > 0 {
                    self.audioService.currentSongIndex -= 1
                    self.changeSongs()
                }
            }) {
                Image(systemName: "backward.fill")
                    .font(.title)
            }
            Button(action: {
                let decrease = self.audioService.getActualSongTime(at: -15)
                let duration = self.audioService.getActualSongDuration()
                self.audioService.audioPlayerNode.seekTo(
                    value: Float((decrease < 0) ? 0 : decrease),
                    audioFile: self.audioService.audioFile,
                    duration: Float(duration + self.audioService.songTimeAdjustment)
                )
                self.audioService.songTimeAdjustment = (decrease < 0) ? 0 : decrease
            }) {
                Image(systemName: "gobackward.15")
                    .font(.title)
            }
            
            Button(action: {
                if self.audioService.audioPlayerNode.isPlaying {
                    self.audioService.barWidthAtPause = self.audioService.songBarWidth
                    self.audioService.audioPlayerNode.pause()
                    
                    self.audioService.paused = true
                    self.audioService.playing = false
                } else {
                    if self.audioService.finished {
                        self.changeSongs()
                    } else {
                        self.audioService.paused = false
                        self.audioService.audioPlayerNode.play()
                        self.audioService.playing = true
                    }
                }
            }) {
                Image(systemName: self.audioService.audioPlayerNode.isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 50))
            }
            
            Button(action: {
                let increase = self.audioService.getActualSongTime(at: 15)
                let duration = self.audioService.getActualSongDuration()
                self.audioService.audioPlayerNode.seekTo(
                    value: (increase < duration) ? Float(increase) : Float(duration),
                    audioFile: self.audioService.audioFile,
                    duration: Float(duration)
                )
                self.audioService.songTimeAdjustment += 15
            }) {
                Image(systemName: "goforward.15")
                    .font(.title)
            }
            
            Button(action: {
                if self.audioService.songs.count - 1 != self.audioService.currentSongIndex {
                    self.audioService.currentSongIndex += 1
                    self.changeSongs()
                }
            }) {
                Image(systemName: "forward.fill")
                    .font(.title)
            }
        }
        .padding(.top, 25)
        .foregroundColor(.white)
    }
    
    
    func changeSongs() {
        self.audioService.audioPlayerNode.stop()
        self.audioService.setAudioFile(
            fileName: self.audioService.songs[self.audioService.currentSongIndex], fileType: "mp3")
        self.audioService.audioData = .init(count: 0)
        self.audioService.audioTitle = ""
        self.audioService.audioArtist = ""
        self.audioService.prepareToPlay()
        self.audioService.extractAudioData()
        self.audioService.songBarWidth = 0
        self.audioService.songTimeAdjustment = 0
        self.audioService.audioPlayerNode.play()
        self.audioService.playing = true
        self.audioService.finished = false
    }
}
