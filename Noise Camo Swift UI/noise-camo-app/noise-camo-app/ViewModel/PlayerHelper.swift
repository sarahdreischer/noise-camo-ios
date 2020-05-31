//
//  AudioEngineHelper.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 31/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation
import AVFoundation

struct PlayerHelper {
    
    static func updateSongBarWidthFactor(playerModel: PlayerViewModel,songModel: SongViewModel, audioService: AudioService) {
        let songDuration = audioService.getActualSongDuration(songFileLength: songModel.songs[songModel.currentSongIndex].length)
        playerModel.songBarWidthFactor = (audioService.audioPlayerNode.currentTime + audioService.songTimeAdjustment) / songDuration
    }
    
    static func instantiateTimer(playerModel: PlayerViewModel) {
        playerModel.timer = Timer.publish (every: 0.1, on: .main, in: .common)
    }

    static func cancelTimer(playerModel: PlayerViewModel) {
        playerModel.timer.connect().cancel()
    }
    
    
    
    
//    .onReceive(self.timer) { _ in
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
