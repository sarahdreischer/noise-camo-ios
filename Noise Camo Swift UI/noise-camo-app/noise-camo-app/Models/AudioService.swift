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
    
    @Published var audioEngine: AVAudioEngine = AVAudioEngine()

    @Published var audioPlayerNode: AVAudioPlayerNode = AVAudioPlayerNode()
    
    @Published var audioFile: AVAudioFile!
    
    @Published var audioData: Data
    
    @Published var audioTitle: String
    
    @Published var songs = ["song", "black", "bad"]
    
    @Published var currentSongIndex = 0
    
    @Published var songBarWidth: CGFloat = 0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    init() {
        audioData = .init(count: 0)
        audioTitle = ""
    }
    
    func setAudioFile(fileName: String, fileType: String) {
        do {
            if let filepath = Bundle.main.path(forResource: fileName, ofType: fileType) {
                let filepathURL = NSURL.fileURL(withPath: filepath)
                audioFile = try AVAudioFile(forReading: filepathURL)
                self.songFileLength = AVAudioFrameCount(audioFile.length)
                self.sampleRate = Float(audioFile.fileFormat.sampleRate)
            }
        } catch {
            print("Something went wrong when setting up the AudioFile")
        }
    }
    
    func attachEqualizer(equalizer: AVAudioUnitEQ) {
        self.audioEngine.attach(self.audioPlayerNode)
        self.audioEngine.attach(equalizer)
        self.audioEngine.connect(self.audioPlayerNode, to: equalizer, format: nil)
        self.audioEngine.connect(equalizer,
            to: self.audioEngine.outputNode,
            format: nil)
    }
    
    
    // For media player only
    func updateBarWidth(maxBarWidth: CGFloat) {
        let songDuration = self.audioPlayerNode.duration(fileLength: Double(self.songFileLength))
        let widthFactor = (self.audioPlayerNode.currentTime + self.songTimeAdjustment) / songDuration
        self.songBarWidth = (self.audioPlayerNode.isPlaying) ? maxBarWidth * CGFloat(widthFactor) : maxBarWidth * CGFloat((self.songTimeAdjustment / songDuration))
    }
    
    func getActualSongTime(at: Double) -> Double {
        return self.audioPlayerNode.currentTime + self.songTimeAdjustment + at
    }
    
    func getActualSongDuration() -> Double {
        return self.audioPlayerNode.duration(fileLength: Double(self.songFileLength))
    }
    
    func prepareToPlay() {
        self.audioPlayerNode.scheduleFile(self.audioFile, at: nil, completionHandler: nil)
        self.audioEngine.prepare()
        do {
        try self.audioEngine.start()
        } catch _ {
            print("Something went wrong when Audio Engine was started.")
        }
    }
    
    // for media player only
    func extractAudioData() {
       let asset = AVAsset(url: self.audioFile.url)
       for i in asset.commonMetadata {
           if i.commonKey?.rawValue == "artwork" {
               let data = i.value as! Data
               self.audioData = data
           }
           if i.commonKey?.rawValue == "title" {
               let title = i.value as! String
               self.audioTitle = title
           }
       }
    }
}
