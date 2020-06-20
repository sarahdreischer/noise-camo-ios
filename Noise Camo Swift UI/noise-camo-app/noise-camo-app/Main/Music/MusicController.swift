//
//  MusicProcessor.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 18/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation
import AVFoundation
import Combine

protocol MusicControllable {
    func play() throws

    func pause()
    
    func skip(nextSong song: AVAudioFile) throws
    
    func seekToTime(_ sec: Int, nextSong song: AVAudioFile) throws
}

class MusicController {
    var audioNode: AVAudioPlayerNode
    
    init(audioNode: AVAudioPlayerNode) {
        self.audioNode = audioNode
    }
}

extension MusicController: MusicControllable {
    func play() throws {
        audioNode.play()
        if !audioNode.isPlaying { throw MusicError.controlling(description: "Cannot play audio file") }
    }
    
    func pause() {
        audioNode.pause()
    }
    
    func skip(nextSong song: AVAudioFile) {
        audioNode.scheduleFile(song, at: nil, completionHandler: nil)
    }
    
    func seekToTime(_ sec: Int, nextSong song: AVAudioFile) throws {
        try? audioNode.seekTo(positionInSeconds: sec, audioFile: song)
    }
}

extension AVAudioPlayerNode {
    func seekTo(positionInSeconds: Int, audioFile: AVAudioFile) throws {
        if self.lastRenderTime != nil {
            let sampleRate = self.outputFormat(forBus: 0).sampleRate
            let newTimePosition = AVAudioFramePosition(Int(sampleRate * Double(positionInSeconds)))
            let duration = Double(audioFile.length) / sampleRate
            if duration != Double.infinity {
                let newLength = duration - Double(positionInSeconds)
                let framesToPlay = AVAudioFrameCount(sampleRate * newLength)
                self.stop()
                if framesToPlay > 1000 {
                    self.scheduleSegment(audioFile,
                                         startingFrame: newTimePosition,
                                         frameCount: framesToPlay,
                                         at: nil,
                                         completionHandler: nil)
                }
            } else {
                throw MusicError.controlling(description: "Song duration is infinity")
            }
        }
    }
}
