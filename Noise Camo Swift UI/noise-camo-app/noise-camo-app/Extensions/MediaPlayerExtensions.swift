//
//  AudioPlayerNodeExtension.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 06/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation
import AVFoundation

//extension AVAudioPlayerNode {
//    var currentTime: TimeInterval {
//        if let nodeTime = lastRenderTime, let playerTime = playerTime(forNodeTime: nodeTime) {
//            return Double(playerTime.sampleTime) / playerTime.sampleRate
//        }
//        return 0
//    }
//    
//    var sampleRate: Double {
//        if let nodeTime = lastRenderTime, let playerTime = playerTime(forNodeTime: nodeTime) {
//            return playerTime.sampleRate
//        }
//        return 0
//    }
//    
//    func seekTo(value: Float, audioFile: AVAudioFile, duration: Float) {
//        if self.lastRenderTime != nil && duration != Float.infinity {
//            let sampleRate = self.outputFormat(forBus: 0).sampleRate
//            let newSampleTime = AVAudioFramePosition(Int(sampleRate * Double(value)))
//            let length = duration - value
//            let framesToPlay = AVAudioFrameCount(Float(sampleRate) * length)
//            self.stop()
//            if framesToPlay > 1000 {
//                self.scheduleSegment(audioFile, startingFrame: newSampleTime, frameCount: framesToPlay, at: nil,completionHandler: nil)
//            }
//        }
//        self.play()
//    }
//    
//    func duration(fileLength: Double) -> TimeInterval {
//        return Double(fileLength / sampleRate)
//    }
//}

//extension AVAudioEngine {
//    func attachEqualizer(equalizer: AVAudioUnitEQ, audioPlayerNode: AVAudioPlayerNode) {
//        self.attach(audioPlayerNode)
//        self.attach(equalizer)
//        self.connect(audioPlayerNode, to: equalizer, format: nil)
//        self.connect(equalizer, to: self.outputNode, format: nil)
//    }
//}
