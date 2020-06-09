//
//  SongViewModel.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 31/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation
import AVFoundation

extension AVAudioPlayerNode {
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
        if self.lastRenderTime != nil && duration != Float.infinity {
            let sampleRate = self.outputFormat(forBus: 0).sampleRate
            let newSampleTime = AVAudioFramePosition(Int(sampleRate * Double(value)))
            let length = duration - value
            let framesToPlay = AVAudioFrameCount(Float(sampleRate) * length)
            self.stop()
            if framesToPlay > 1000 {
                self.scheduleSegment(audioFile, startingFrame: newSampleTime, frameCount: framesToPlay, at: nil,completionHandler: nil)
            }
        }
        self.play()
    }
    
    func duration(fileLength: Double) -> TimeInterval {
        return Double(fileLength / sampleRate)
    }
}
class SongViewModel: ObservableObject {
    @Published var songs = [SongModel]()
    @Published var currentSongIndex = 0
    @Published var songBarWidthFactor: Double = 0
    @Published var timer = Timer.publish(every: 0.1, on: .main, in: .common)
    @Published var audioEngine: AVAudioEngine = AVAudioEngine()
    @Published var audioPlayerNode: AVAudioPlayerNode = AVAudioPlayerNode()
    private let songList = ["song", "black", "bad"]
    
    init() {
        songList.forEach { song in
            do {
                if let path = Bundle.main.path(forResource: song, ofType: "mp3") {
                    let url = NSURL.fileURL(withPath: path)
                    let audioFile = try AVAudioFile(forReading: url)
                    var songArtwork: Data = .init(count: 0)
                    var songTitle = ""
                    var songArtist = ""
                    let asset = AVAsset(url: url)
                    extractAudioMetadata(asset, &songArtwork, &songTitle, &songArtist)
                    songs.append(
                        SongModel.init(audioFile: audioFile, audioArtwork: songArtwork, audioTitle: songTitle, audioArtist: songArtist, audioLength: Double(audioFile.length))
                    )
                    print("Current song index \(currentSongIndex)")
                    print("Current song \(songs[currentSongIndex])")
                }
            } catch {
                print("Could not create audio file from \(song).mp3")
            }
        }
    }
    
    public func attachEqualizer(equalizer: AVAudioUnitEQ) {
        self.audioEngine.attach(self.audioPlayerNode)
        self.audioEngine.attach(equalizer)
        self.audioEngine.connect(self.audioPlayerNode, to: equalizer, format: nil)
        self.audioEngine.connect(equalizer,
            to: self.audioEngine.outputNode,
            format: nil)
    }
    
    public func prepareToPlay() {
        self.audioPlayerNode.scheduleFile(songs[currentSongIndex].audioFile!, at: nil, completionHandler: nil)
        self.audioEngine.prepare()
        do {
        try self.audioEngine.start()
        } catch _ {
            print("Something went wrong when Audio Engine was started.")
        }
    }
    
    public func play() {
        instantiateTimer()
        if !songs[currentSongIndex].paused {
            print("Song resetted")
            prepareToPlay()
            songs[currentSongIndex].reset()
        } else {
            print("Song unpaused")
            songs[currentSongIndex].paused = false
        }
        songs[currentSongIndex].playing = true
        self.audioPlayerNode.play()
        songs[currentSongIndex].sampleRate = audioPlayerNode.sampleRate
        songs[currentSongIndex].updateDuration()
        timer.connect()
    }
    
    public func pause() {
        cancelTimer()
        songs[currentSongIndex].paused = true
        songs[currentSongIndex].playing = false
        self.audioPlayerNode.pause()
    }
    
    public func stop() {
        self.audioPlayerNode.stop()
    }
    
    public func next(_ direction: SongDirection) {
        stop()
        currentSongIndex = direction.getNewIndex(index: currentSongIndex, count: songs.count)
        songs[currentSongIndex].reset()
        play()
        print(currentSongIndex)
    }
    
    public func checkIfSongFinished() {
        if songs[currentSongIndex].playingTime >= songs[currentSongIndex].duration {
            print("Song finished")
            songs[currentSongIndex].playing = false
            songs[currentSongIndex].finished = true
            cancelTimer()
        }
    }
    
    public func jumpTo(_ second: Double, _ direction: SongDirection) {
        if songs[currentSongIndex].playing {
            if direction == SongDirection.forward {
                if songs[currentSongIndex].playingTime + second > songs[currentSongIndex].duration {
                    songs[currentSongIndex].audioAdjustmentTime = songs[currentSongIndex].duration - 1
                } else {
                    songs[currentSongIndex].audioAdjustmentTime += second
                }
            } else {
                if songs[currentSongIndex].audioAdjustmentTime - second < 0 {
                    songs[currentSongIndex].audioAdjustmentTime = 0
                } else {
                    songs[currentSongIndex].audioAdjustmentTime -= second
                }
            }
            audioPlayerNode.seekTo(
            value: Float(audioPlayerNode.currentTime + songs[currentSongIndex].audioAdjustmentTime),
            audioFile: songs[currentSongIndex].audioFile!,
            duration: Float(songs[currentSongIndex].duration))
        }
    }
    
    public func seekTo(_ time: Double) {
        songs[currentSongIndex].audioAdjustmentTime = time
        audioPlayerNode.seekTo(value: Float(time), audioFile: songs[currentSongIndex].audioFile!, duration: Float(songs[currentSongIndex].duration))
        if !songs[currentSongIndex].playing { pause() }
    }
    
    public func updateSongBarWidthFactor() {
        songBarWidthFactor = songs[currentSongIndex].playingTime / songs[currentSongIndex].duration
    }
    
    public func updatePlayingTime() {
        songs[currentSongIndex].playingTime = audioPlayerNode.currentTime + songs[currentSongIndex].audioAdjustmentTime
    }
    
    public func instantiateTimer() {
        self.timer = Timer.publish (every: 0.1, on: .main, in: .common)
    }

    public func cancelTimer() {
        self.timer.connect().cancel()
    }
    
    fileprivate func extractAudioMetadata(_ asset: AVAsset, _ songArtwork: inout Data, _ songTitle: inout String, _ songArtist: inout String) {
        asset.commonMetadata.forEach { attribute in
            if attribute.commonKey?.rawValue == "artwork" { songArtwork = attribute.value as! Data }
            else if attribute.commonKey?.rawValue == "title" { songTitle = attribute.value as! String }
            else if attribute.commonKey?.rawValue == "artist" { songArtist = attribute.value as! String }
        }
    }
}
