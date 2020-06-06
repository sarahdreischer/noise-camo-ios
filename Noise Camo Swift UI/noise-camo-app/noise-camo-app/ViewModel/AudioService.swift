//
//  EqualizerSettings.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 10/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI
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

class AudioService: ObservableObject {
//    @Published var audioEngine: AVAudioEngine = AVAudioEngine()
//    @Published var audioPlayerNode: AVAudioPlayerNode = AVAudioPlayerNode()
//    
//    public func attachEqualizer(equalizer: AVAudioUnitEQ) {
//        self.audioEngine.attach(self.audioPlayerNode)
//        self.audioEngine.attach(equalizer)
//        self.audioEngine.connect(self.audioPlayerNode, to: equalizer, format: nil)
//        self.audioEngine.connect(equalizer,
//            to: self.audioEngine.outputNode,
//            format: nil)
//    }
//    
//    public func prepareToPlay(audioFile: AVAudioFile) {
//        self.audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
//        self.audioEngine.prepare()
//        do {
//        try self.audioEngine.start()
//        } catch _ {
//            print("Something went wrong when Audio Engine was started.")
//        }
//    }
//    
//    public func play() {
//        self.audioPlayerNode.play()
//    }
//    
//    public func pause() {
//        self.audioPlayerNode.pause()
//    }
//    
//    public func stop() {
//        self.audioPlayerNode.stop()
//    }
}
