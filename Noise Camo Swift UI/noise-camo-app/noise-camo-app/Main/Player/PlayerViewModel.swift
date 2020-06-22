//
//  PlayerViewModel.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 14/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation
import AVFoundation
import SwiftUI
import Combine

class PlayerViewModel: ObservableObject, Identifiable {
    
    private let musicFetcher: MusicFetchable
    
    private let musicController: MusicControllable
    
    private var disposables = Set<AnyCancellable>()
    
    private let songs = ["song", "bad", "black"]
    
    @Published var song: MusicAssetViewModel?
    
    @Published var dataSource: [MusicAssetViewModel] = []
    
    @Published var paused: Bool = true
    
    @Published var finished: Bool = false
    
    init(musicFetcher: MusicFetchable, musicController: MusicControllable) {
        self.musicFetcher = musicFetcher
        self.musicController = musicController
        songs.forEach { fetchMusic(forSong: $0) }
    }
    
    func fetchMusic(forSong song: String) {
        musicFetcher.track(forSong: song)
            .sink(receiveCompletion: { err in
                print(".sink() received the completion", String(describing: err))
            }, receiveValue: { asset in
                let musicAssetViewModel = MusicAssetViewModel(item: asset)
                print(musicAssetViewModel.artist)
                self.dataSource.append(musicAssetViewModel)
            })
            .store(in: &disposables)
    }
    
    func initialisePlayerNode() {
        let index = dataSource.firstIndex(where: { $0.id == self.song?.id })
        try? musicFetcher.initPlayerEngine(forSong: songs[index ?? 0])
    }
    
    func playOrPause() {
        do {
            if (!finished) {
                try (paused) ? musicController.play() : musicController.pause()
            } else {
                try musicController.skip(nextSong: AVAudioFile.init(forReading: song?.url ?? dataSource[0].url))
                try musicController.play()
            }
            paused.toggle()
        } catch {
            print("Couldn't start song, unexpected error: \(error)")
        }
    }
    
    func backward(_ sec: Int = 0) {
        if sec == 0 {
            let index = dataSource.firstIndex(where: { $0.id == self.song?.id })
            song = (index == 0) ? dataSource[dataSource.count - 1] : dataSource[(index ?? 1) - 1]
            try? musicController.skip(nextSong: AVAudioFile.init(forReading: song?.url ?? dataSource[0].url))
            try? (paused) ? musicController.pause() : musicController.play()
        } else {
            try? musicController.seekToTime(-1 * sec, forSong: AVAudioFile.init(forReading: song?.url ?? dataSource[0].url))
            try? musicController.play()
            print("Go backward by \(sec) seconds")
        }
    }
    
    func forward(_ sec: Int = 0) {
        if sec == 0 {
            let index = dataSource.firstIndex(where: { $0.id == self.song?.id })
            song = (index == (dataSource.count - 1)) ? dataSource[0] : dataSource[(index ?? 0) + 1]
            try? musicController.skip(nextSong: AVAudioFile.init(forReading: song?.url ?? dataSource[0].url))
            try? (paused) ? musicController.pause() : musicController.play()
        } else {
            try? musicController.seekToTime(sec, forSong: AVAudioFile.init(forReading: song?.url ?? dataSource[0].url))
            if !musicController.isPlaying() {
                paused = true
                finished = true
            }
            print("Go forward by \(sec) seconds")
        }
    }
}
