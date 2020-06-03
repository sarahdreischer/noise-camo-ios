//
//  SongModel.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 31/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation
import AVFoundation

struct SongModel: Identifiable {
    
    var id: UUID
    var audioFile: AVAudioFile?
    var audioArtwork: Data?
    var audioTitle: String?
    var audioArtist: String?
    var paused: Bool
    var finished: Bool
    var playing: Bool
    var length: Double
    var audioAdjustmentTime: Double
    var sampleRate: Double
    var duration: Double
    var playingTime: Double
    
    init(audioFile: AVAudioFile, audioArtwork: Data, audioTitle: String, audioArtist: String, audioLength: Double) {
        id = UUID()
        self.audioFile = audioFile
        self.audioArtwork = audioArtwork
        self.audioTitle = audioTitle
        self.audioArtist = audioArtist
        paused = false
        finished = false
        playing = false
        length = audioLength
        audioAdjustmentTime = 0
        sampleRate = 0
        duration = 0
        playingTime = 0
    }
    
    public mutating func reset() {
        paused = false
        finished = false
        playing = false
        audioAdjustmentTime = 0
        sampleRate = 0
        duration = 0
        playingTime = 0
    }
}
