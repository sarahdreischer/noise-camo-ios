////
////  MediaPlayerService.swift
////  noise-camo-app
////
////  Created by Sarah Dreischer on 05/06/2020.
////  Copyright © 2020 Sarah Dreischer. All rights reserved.
////
//// Service layer connects SongViewModel, PlayerViewModel and AudioService layers
////
//
//import Foundation
//import SwiftUI
//
//struct MediaPlayerService: View {
//    
//    @ObservedObject var songs: SongViewModel
//    var player: PlayerViewModel
//    var audio: AudioService
//    
//    public func play() {
//        if songs[songs.currentSongIndex].playing {
//            songs.pause()
//            audio.pause()
//        } else if songs[songs.currentSongIndex].paused {
//            songs.play()
//            audio.play()
//        } else {
//            player.reset()
//            songs[songs.currentSongIndex].reset()
//            audioService.prepareToPlay(audioFile: songModel.songs[songModel.currentSongIndex].audioFile!)
//            audioService.audioPlayerNode.play()
//            playerModel.timer.connect()
//            songModel.songs[songModel.currentSongIndex].playing = true
//            songModel.songs[songModel.currentSongIndex].sampleRate = audioService.audioPlayerNode.sampleRate
//            songModel.songs[songModel.currentSongIndex].updateDuration()
//            print(songModel.songs[songModel.currentSongIndex])
//        }
//    }
//    
//    static func pauseSong(songModel: SongViewModel, audioServices: AudioService) {
//        audioServices.audioPlayerNode.pause()
//        songModel.songs[songModel.currentSongIndex].paused = true
//        songModel.songs[songModel.currentSongIndex].playing = false
//    }
//    
//    static func changeSong(_ direction: SongDirection, songModel: SongViewModel, audioService: AudioService, playerModel: PlayerViewModel) {
//        audioService.audioPlayerNode.stop()
//        songModel.currentSongIndex = direction.getNewIndex(index: songModel.currentSongIndex, count: songModel.songs.count)
//        playerModel.reset()
//        songModel.songs[songModel.currentSongIndex].reset()
//        playSong(songModel: songModel, audioService: audioService, playerModel: playerModel)
//        print(songModel.songs[songModel.currentSongIndex])
//    }
//    
//    static func songFinished(songModel: SongViewModel, audioService: AudioService, playerModel: PlayerViewModel) {
//        if (audioService.getActualSongTime(songAdjustmentTime: songModel.songs[songModel.currentSongIndex].audioAdjustmentTime) >= songModel.songs[songModel.currentSongIndex].duration) {
//            print("Song is finished")
//            songModel.songs[songModel.currentSongIndex].playing = false
//            songModel.songs[songModel.currentSongIndex].finished = true
//            MediaPlayerHelper.cancelTimer(playerModel: playerModel)
//        }
//    }
//    
//    static func jumpTo(_ second: Double, _ direction: SongDirection, songModel: SongViewModel, audioService: AudioService) {
//        if songModel.songs[songModel.currentSongIndex].playing {
//            let position = audioService.getActualSongTime(songAdjustmentTime: songModel.songs[songModel.currentSongIndex].audioAdjustmentTime)
//            let duration = songModel.songs[songModel.currentSongIndex].duration
//            let newPosition = direction.getNewTimePosition(position: position, change: second, duration: duration)
//            audioService.audioPlayerNode.seekTo(
//                value: Float(newPosition),
//                audioFile: songModel.songs[songModel.currentSongIndex].audioFile!,
//                duration: Float(duration)
//            )
//            songModel.songs[songModel.currentSongIndex].audioAdjustmentTime = direction.getNewAdjustmentTime(current: songModel.songs[songModel.currentSongIndex].audioAdjustmentTime, newPosition: newPosition, oldPosition: position)
//        }
//    }
//    
//    static func updatePlayingTime(songModel: SongViewModel, audioService: AudioService) {
//        songModel.songs[songModel.currentSongIndex].playingTime = audioService.getActualSongTime(songAdjustmentTime: songModel.songs[songModel.currentSongIndex].audioAdjustmentTime)
//    }
//}
