//
//  MusicFetcher.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 13/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation
import AVFoundation
import Combine

protocol MusicFetchable {
    func track(forSong song: String) -> AnyPublisher<AVURLAsset, MusicError>
    
    func initPlayerEngine(forSong song: String) throws
}

class MusicFetcher {
    var audioNode = AVAudioPlayerNode()
    var audioEngine = AVAudioEngine()
    var equalizer = EqualizerService()
}

extension MusicFetcher: MusicFetchable {
    func track(forSong song: String) -> AnyPublisher<AVURLAsset, MusicError> {
        return makeTrack(forSong: song)
    }
    
    func initPlayerEngine(forSong song: String) throws {
        initAudioEngine()
        try? initAudioNode(forSong: song)
        print("Initializing audio node...")
    }
    
    private func makeTrack(forSong song: String) -> AnyPublisher<AVURLAsset, MusicError> {
        guard let path = Bundle.main.path(forResource: song, ofType: "mp3") else {
            let error = MusicError.parsing(description: "Could not create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        let url = NSURL.fileURL(withPath: path)
        return Just(AVURLAsset(url: url, options: nil)).setFailureType(to: MusicError.self).eraseToAnyPublisher()
    }
    
    private func initAudioEngine() {
        equalizer.setBands(bands: equalizer.equalizer.bands)
        audioEngine.attach(audioNode)
        audioEngine.attach(equalizer.equalizer)
        audioEngine.connect(audioNode, to: equalizer.equalizer, format: nil)
        audioEngine.connect(equalizer.equalizer, to: audioEngine.outputNode, format: nil)
        print("Starting the audio engine...")
        audioEngine.prepare()
        try? audioEngine.start()
    }
    
    private func initAudioNode(forSong song: String) throws {
        guard let path = Bundle.main.path(forResource: song, ofType: "mp3") else {
            throw MusicError.parsing(description: "Could not create URL")
        }
        let url = NSURL.fileURL(withPath: path)
        let file = (try? AVAudioFile(forReading: url)) ?? AVAudioFile()
        audioNode.scheduleFile(file, at: nil, completionHandler: nil)
    }
    
    func mockTrack() -> AVURLAsset {
        let path = Bundle.main.path(forResource: "song", ofType: "mp3")
        let url = NSURL.fileURL(withPath: path!)
        return AVURLAsset(url: url, options: nil)
    }
}
