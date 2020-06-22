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

    func pause() throws
    
    func skip(nextSong song: AVAudioFile) throws
    
    func seekToTime(_ sec: Int, forSong song: AVAudioFile) throws
    
    func isPlaying() -> Bool
}

class MusicController {
    private var audioNode: AVAudioPlayerNode
    
    private var audioAdjustmentTime: Int = 0
    
    init(audioNode: AVAudioPlayerNode) {
        self.audioNode = audioNode
    }
}

extension MusicController: MusicControllable {
    func play() throws {
        audioNode.play()
        if !audioNode.isPlaying { throw MusicError.controlling(description: "Cannot play audio file") }
    }
    
    func pause() throws {
        audioNode.pause()
        if audioNode.isPlaying { throw MusicError.controlling(description: "Cannot pause audio file") }
    }
    
    func skip(nextSong song: AVAudioFile) {
        audioNode.stop()
        audioNode.scheduleFile(song, at: nil, completionHandler: nil)
    }
    
    func seekToTime(_ sec: Int, forSong song: AVAudioFile) throws {
        do {
            try audioNode.seekTo(positionInSeconds: sec, adjustmentTime: audioAdjustmentTime, audioFile: song)
            audioAdjustmentTime = getNewAudioTimeAdjustment(lastAdjustmentTime: audioAdjustmentTime, newTime: sec)
        } catch { audioAdjustmentTime = 0 }
    }
    
    func isPlaying() -> Bool {
        return audioNode.isPlaying
    }
    
    private func getNewAudioTimeAdjustment(lastAdjustmentTime: Int, newTime: Int) -> Int {
        return lastAdjustmentTime + newTime
    }
}

extension AVAudioPlayerNode {
    func seekTo(positionInSeconds: Int, adjustmentTime: Int, audioFile: AVAudioFile) throws {
        if self.lastRenderTime != nil {
            let sampleRate = self.outputFormat(forBus: 0).sampleRate
            let newTimePosition = Double(positionInSeconds) + (Double(self.lastRenderTime!.sampleTime) / sampleRate) + Double(adjustmentTime)
            let newFramePosition = AVAudioFramePosition(newTimePosition * sampleRate)
            let duration = Double(audioFile.length) / sampleRate
            self.play(at: AVAudioTime.init(sampleTime: newFramePosition, atRate: sampleRate))
            if duration != Double.infinity {
                let newLength = duration - newTimePosition
                if newLength >= 0 && newLength <= duration {
                    let framesToPlay = AVAudioFrameCount(sampleRate * newLength)
                    self.stop()
                    scheduleSegment(audioFile, startingFrame: newFramePosition, frameCount: framesToPlay, at: nil, completionHandler: nil)
                    self.play()
                } else if newLength <= 0 {
                    self.stop()
                    throw MusicError.controlling(description: "Song has finished.")
                } else {
                    self.stop()
                    scheduleFile(audioFile, at: nil, completionHandler: nil)
                    self.play()
                    throw MusicError.controlling(description: "Song is fully loaded.")
                }
            } else {
                throw MusicError.controlling(description: "Song duration is infinity")
            }
        }
    }
}
