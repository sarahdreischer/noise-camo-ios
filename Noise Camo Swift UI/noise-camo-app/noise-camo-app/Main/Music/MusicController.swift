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
    
    func isFinished(audioFile: AVAudioFile) -> Bool
}

class MusicController {
    private var audioNode: AVAudioPlayerNode
    
    private var audioAdjustmentTime: Int = 0
    
    private var wasPaused: Bool = false
    
    init(audioNode: AVAudioPlayerNode) {
        self.audioNode = audioNode
    }
}

extension MusicController: MusicControllable {
    func play() throws {
        audioNode.play()
        if !audioNode.isPlaying { throw MusicError.controlling(description: "Cannot play audio file") }
        wasPaused = false
    }
    
    func pause() throws {
        audioNode.pause()
        if audioNode.isPlaying { throw MusicError.controlling(description: "Cannot pause audio file") }
        wasPaused = true
    }
    
    func skip(nextSong song: AVAudioFile) {
        audioNode.stop()
        audioNode.scheduleFile(song, at: nil, completionHandler: nil)
    }
    
    func seekToTime(_ sec: Int, forSong song: AVAudioFile) throws {
        do {
            try audioNode.seekTo(positionInSeconds: sec, adjustmentTime: audioAdjustmentTime, audioFile: song)
            updateAudioAdjustmentTime(addedSeconds: sec)
        } catch { audioAdjustmentTime = 0 }
    }
    
    func isPlaying() -> Bool {
        return audioNode.isPlaying
    }
    
    func isFinished(audioFile: AVAudioFile) -> Bool {
        return audioNode.isFinished(adjustmentTime: audioAdjustmentTime, audioFile: audioFile, wasPaused: wasPaused)
    }
    
    private func updateAudioAdjustmentTime(addedSeconds: Int) {
        audioAdjustmentTime += addedSeconds
    }
}

extension AVAudioPlayerNode {
    func seekTo(positionInSeconds: Int, adjustmentTime: Int, audioFile: AVAudioFile) throws {
        if self.lastRenderTime != nil {
            let sampleRate = self.outputFormat(forBus: 0).sampleRate
            let duration = Double(audioFile.length) / sampleRate
            let newPlayerTime = Double(positionInSeconds) + getPlayerTime(adjustmentTime: adjustmentTime)
            let newFramePosition = AVAudioFramePosition(newPlayerTime * sampleRate)
            
            if duration != Double.infinity {
                let newDuration = duration - newPlayerTime
                if newDuration >= 0 && newDuration <= duration {
                    let framesToPlay = AVAudioFrameCount(sampleRate * newDuration)
                    self.stop()
                    scheduleSegment(audioFile, startingFrame: newFramePosition, frameCount: framesToPlay, at: nil, completionHandler: nil)
                    
                } else {
                    self.stop()
                    if (newDuration <= 0) { throw MusicError.controlling(description: "Song has finished.") }
                    if (newDuration >= duration) {
                        scheduleFile(audioFile, at: nil, completionHandler: nil)
                        throw MusicError.controlling(description: "Song is fully loaded.")
                    }
                }
            } else {
                throw MusicError.controlling(description: "Song duration is infinity")
            }
        }
    }
    
    func isFinished(adjustmentTime: Int, audioFile: AVAudioFile, wasPaused: Bool) -> Bool {
        let currentTime = self.getPlayerTime(adjustmentTime: adjustmentTime)
        if currentTime != -1 {
            let sampleRate = self.outputFormat(forBus: 0).sampleRate
            let duration = Double(audioFile.length) / sampleRate
            if duration != Double.infinity {
                return (currentTime >= duration) ? true : false
            }
        }
        return (wasPaused) ? false : true // change to error because current playing time can't be found
    }
    
    func getPlayerTime(adjustmentTime: Int) -> Double {
        if let nodeTime = lastRenderTime, let playerTime = playerTime(forNodeTime: nodeTime) {
            return (Double(playerTime.sampleTime) / playerTime.sampleRate) + Double(adjustmentTime)
        }
        return -1
    }
}
