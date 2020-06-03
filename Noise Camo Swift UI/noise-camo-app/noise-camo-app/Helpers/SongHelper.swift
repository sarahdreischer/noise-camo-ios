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
    static func playSong(songModel: SongViewModel, audioService: AudioService, playerModel: PlayerViewModel) {
        if songModel.songs[songModel.currentSongIndex].playing {
            print("Song paused")
            pauseSong(songModel: songModel, audioServices: audioService)
        } else if songModel.songs[songModel.currentSongIndex].paused {
            print("Song unpaused")
            songModel.songs[songModel.currentSongIndex].paused = false
            songModel.songs[songModel.currentSongIndex].playing = true
            audioService.audioPlayerNode.play()
        } else {
            playerModel.reset()
            songModel.resetCurrentSong()
            audioService.prepareToPlay(audioFile: songModel.songs[songModel.currentSongIndex].audioFile!)
            audioService.audioPlayerNode.play()
            playerModel.timer.connect()
            songModel.songs[songModel.currentSongIndex].playing = true
            songModel.songs[songModel.currentSongIndex].sampleRate = audioService.audioPlayerNode.sampleRate
            songModel.updateDuration()
            print(songModel.songs[songModel.currentSongIndex])
        }
    }
    
    static func pauseSong(songModel: SongViewModel, audioServices: AudioService) {
        audioServices.audioPlayerNode.pause()
        songModel.songs[songModel.currentSongIndex].paused = true
        songModel.songs[songModel.currentSongIndex].playing = false
    }
    
    static func changeSong(_ direction: SongDirection, songModel: SongViewModel, audioService: AudioService, playerModel: PlayerViewModel) {
        audioService.audioPlayerNode.stop()
        songModel.currentSongIndex = direction.getNewIndex(index: songModel.currentSongIndex, count: songModel.songs.count)
        playerModel.reset()
        songModel.resetCurrentSong()
        playSong(songModel: songModel, audioService: audioService, playerModel: playerModel)
        print(songModel.songs[songModel.currentSongIndex])
    }
    
    static func songFinished(songModel: SongViewModel, audioService: AudioService, playerModel: PlayerViewModel) {
        if (audioService.getActualSongTime(songAdjustmentTime: songModel.songs[songModel.currentSongIndex].audioAdjustmentTime) >= songModel.songs[songModel.currentSongIndex].duration) {
            print("Song is finished")
            songModel.songs[songModel.currentSongIndex].playing = false
            songModel.songs[songModel.currentSongIndex].finished = true
            PlayerHelper.cancelTimer(playerModel: playerModel)
        }
    }
    
    static func jumpTo(_ second: Double, _ direction: SongDirection, songModel: SongViewModel, audioService: AudioService) {
        if songModel.songs[songModel.currentSongIndex].playing {
            let position = audioService.getActualSongTime(songAdjustmentTime: songModel.songs[songModel.currentSongIndex].audioAdjustmentTime)
            let duration = songModel.songs[songModel.currentSongIndex].duration
            let newPosition = direction.getNewTimePosition(position: position, change: second, duration: duration)
            audioService.audioPlayerNode.seekTo(
                value: Float(newPosition),
                audioFile: songModel.songs[songModel.currentSongIndex].audioFile!,
                duration: Float(duration)
            )
            songModel.songs[songModel.currentSongIndex].audioAdjustmentTime = direction.getNewAdjustmentTime(current: songModel.songs[songModel.currentSongIndex].audioAdjustmentTime, newPosition: newPosition, oldPosition: position)
        }
    }
    
    static func updatePlayingTime(songModel: SongViewModel, audioService: AudioService) {
        songModel.songs[songModel.currentSongIndex].playingTime = audioService.getActualSongTime(songAdjustmentTime: songModel.songs[songModel.currentSongIndex].audioAdjustmentTime)
    }

}
