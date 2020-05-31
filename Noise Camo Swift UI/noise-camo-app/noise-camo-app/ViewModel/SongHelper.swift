//
//  SongHelper.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 31/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation
import AVFoundation

struct SongHelper {
    
    static func changeSong(songModel: SongViewModel, audioService: AudioService, playerModel: PlayerViewModel) {
        audioService.audioPlayerNode.stop()
        songModel.currentSongIndex = (songModel.currentSongIndex < (songModel.songs.count-1)) ? (songModel.currentSongIndex+1) : 0
        playerModel.songBarWidthFactor = 0
        audioService.initSong()
        audioService.prepareToPlay(audioFile: songModel.songs[songModel.currentSongIndex].audioFile!)
        audioService.audioPlayerNode.play()
        songModel.songs[songModel.currentSongIndex].playing = true
        songModel.songs[songModel.currentSongIndex].finished = false
    }
    
    static func songFinished(songModel: SongViewModel, audioService: AudioService, playerModel: PlayerViewModel) {
        if audioService.getActualSongTime(at: 0) >= audioService.getActualSongDuration(songFileLength: songModel.songs[songModel.currentSongIndex].length) {
            print("Song is finished")
            songModel.songs[songModel.currentSongIndex].finished = true
            PlayerHelper.cancelTimer(playerModel: playerModel)
        }
    }

}
