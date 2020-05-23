//
//  EqualizerSettings.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 10/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI
import AVFoundation

extension AVAudioPlayerNode{
    var currentTime: TimeInterval {
        if let nodeTime = lastRenderTime, let playerTime = playerTime(forNodeTime: nodeTime) {
            return Double(playerTime.sampleTime) / playerTime.sampleRate
        }
        return 0
    }
    
    var sampleRate: Double {
        if let nodeTime = lastRenderTime, let playerTime = playerTime(forNodeTime: nodeTime) {
            return playerTime.sampleRate
        }
        return 0
    }
    
    func seekTo(value: Float, audioFile: AVAudioFile, duration: Float) {
        if self.lastRenderTime != nil {
            let sampleRate = self.outputFormat(forBus: 0).sampleRate
            let newsampletime = AVAudioFramePosition(Int(sampleRate * Double(value)))
            let length = duration - value
            let framestoplay = AVAudioFrameCount(Float(sampleRate) * length)
            self.stop()

            if framestoplay > 1000 {
                self.scheduleSegment(audioFile, startingFrame: newsampletime, frameCount: framestoplay, at: nil,completionHandler: nil)
            }
        }
        self.play()
    }
    
    func duration(fileLength: Double) -> TimeInterval {
        return Double(fileLength / self.sampleRate)
    }
}

class AudioService: ObservableObject {
    var songFileLength: AVAudioFrameCount = 0
    var sampleRate: Float = 0
    var songTimeAdjustment: Double = 0
    
    @Published var currentGain: Array<Double>
    
    @Published var audioEngine: AVAudioEngine = AVAudioEngine()

    @Published var audioPlayerNode: AVAudioPlayerNode = AVAudioPlayerNode()

    @Published var equalizer: AVAudioUnitEQ
        = AVAudioUnitEQ(numberOfBands: 6)
    
    @Published var audioFile: AVAudioFile!
    init() {
        currentGain = Array(repeating: 0.0, count: EqualizerData().frequencies.count)
        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(equalizer)
        audioEngine.connect(audioPlayerNode, to: equalizer, format: nil)
        audioEngine.connect(equalizer, to: audioEngine.outputNode, format: nil)
    }
    
    func getShelf(_ gain:Double) -> AVAudioUnitEQFilterType {
        if gain<0 { return AVAudioUnitEQFilterType.lowShelf }
        return AVAudioUnitEQFilterType.highShelf
    }
    
    func setBands(bands: [AVAudioUnitEQFilterParameters]) {
           for i in 0...(bands.count - 1) {
            bands[i].frequency  = Float(EqualizerData().frequencies[i])
               bands[i].bypass     = false
               bands[i].gain = Float(currentGain[0])
               bands[i].filterType = getShelf(currentGain[i])
           }
    }
    
    func getAudioFile(fileName: String, fileType: String) {
        do {
            if let filepath = Bundle.main.path(forResource: fileName, ofType: fileType) {

                let filepathURL = NSURL.fileURL(withPath: filepath)

                audioFile = try AVAudioFile(forReading: filepathURL)
                
                self.songFileLength = AVAudioFrameCount(audioFile.length)
                self.sampleRate = Float(audioFile.fileFormat.sampleRate)
                print("Sample rate \(self.sampleRate)")
            }
        } catch {
            print("Something went wrong when setting up the AudioFile")
        }
    }
}
