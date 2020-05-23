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
    
    private let screenWidth = UIScreen.main.bounds.width - 30
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Image(uiImage: self.audioService.audioData.count == 0 ? UIImage(named: "itunes")! : UIImage(data: self.audioService.audioData)!)
                .resizable()
                .frame(width: self.audioService.audioData.count == 0 ? 250 : nil, height: 250)
                .cornerRadius(15)
                
            Text(self.audioService.audioTitle)
                .font(.title)
                .foregroundColor(.white)
                .padding(.top)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white.opacity(0.6))
                    .frame(height: 8)
                Capsule()
                    .fill(Color("top"))
                    .onReceive(self.audioService.timer) { _ in
                        self.audioService.updateBarWidth(maxBarWidth: self.screenWidth)
                    }
                    .frame(width: self.audioService.songBarWidth, height: 8)
            }
            .padding(.top)
            
            HStack(spacing: UIScreen.main.bounds.width / 5 - 30) {
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
                        self.audioService.audioPlayerNode.pause()
                    } else {
                        self.audioService.audioPlayerNode.play()
                    }
                }) {
                    Image(systemName: self.audioService.audioPlayerNode.isPlaying ? "pause.fill" : "play.fill")
                        .font(.title)
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
            
            Spacer()
         
        }
        .onAppear {
            self.eqService.setBands(bands: self.eqService.equalizer.bands)
            self.audioService.attachEqualizer(equalizer: self.eqService.equalizer)
            self.audioService.setAudioFile(fileName: self.audioService.songs[self.audioService.currentSongIndex], fileType: "mp3")
            self.audioService.prepareToPlay()
            self.audioService.extractAudioData()
        }
    }

    func changeSongs() {
        self.audioService.audioPlayerNode.stop()
        self.audioService.setAudioFile(
            fileName: self.audioService.songs[self.audioService.currentSongIndex], fileType: "mp3")
        self.audioService.audioData = .init(count: 0)
        self.audioService.audioTitle = ""
        self.audioService.prepareToPlay()
        self.audioService.extractAudioData()
        self.audioService.songBarWidth = 0
        self.audioService.audioPlayerNode.play()
        
        print("Song Bar Width: \(self.audioService.songBarWidth)")
    }
}

struct MediaPlayerView_Previews: PreviewProvider {
    static let audioService = AudioService()
    static let eqService = EqualizerService()
    static var previews: some View {
        MediaPlayerView()
            .environmentObject(audioService)
            .environmentObject(eqService)
            .modifier(PageViewWrapper(pageTitle: "Media Player"))
    }
}
