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
    
    private var songTimer: AnyCancellable?
    
    private var songLoaded: Bool = false
    
    @Published var song: MusicAssetViewModel?
    
    @Published var dataSource: [MusicAssetViewModel] = []
    
    @Published var paused: Bool = false
    
    @Published var finished: Bool = true
    
    init(musicFetcher: MusicFetchable, musicController: MusicControllable) {
        self.musicFetcher = musicFetcher
        self.musicController = musicController
        songs.forEach { fetchMusic(forSong: $0) }
        self.songTimer = startTimer()
    }
    
    func startTimer() -> AnyCancellable {
        return Timer.publish(every: 0.5, on: RunLoop.main, in: .common)
        .autoconnect()
        .sink { [unowned self] _ in
            self.paused = !self.musicController.isPlaying()
            print("Song is paused: \(self.paused)")
            self.finished = self.musicController.isFinished(audioFile: try! self.getAudioFile())
            if (self.finished) { self.paused = true }
            print("Song is finished: \(self.finished)")
        }
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
        let index = getSongIndex(fromDataSource: song ?? dataSource[0])
        try? musicFetcher.initPlayerEngine(forSong: songs[index])
    }
    
    func playOrPause() {
        do {
            if (!finished) {
                try (paused) ? musicController.play() : musicController.pause()
            } else {
//                if (!songLoaded) {
                    try musicController.skip(nextSong: getAudioFile())
//                    songLoaded.toggle()
//                }
                try musicController.play()
            }
        } catch {
            print("Couldn't start song, unexpected error: \(error)")
        }
    }
    
    func backward(_ sec: Int = 0) {
        if sec == 0 {
            let index = getSongIndex(fromDataSource: song)
            skipToSong(songIndex: index - 1)
        } else {
            try? musicController.seekToTime(-1 * sec, forSong: getAudioFile())
            if !paused { try? musicController.play() }
        }
    }
    
    func forward(_ sec: Int = 0) {
        if sec == 0 {
            let index = getSongIndex(fromDataSource: song)
            skipToSong(songIndex: index + 1)
        } else {
            try? musicController.seekToTime(sec, forSong: getAudioFile())
            if !paused { try? musicController.play() }
        }
    }
    
    private func getSongIndex(fromDataSource song: MusicAssetViewModel?) -> Int {
        return dataSource.firstIndex(where: { $0.id == song?.id }) ?? 0
    }
    
    private func skipToSong(songIndex: Int) {
        if songIndex > dataSource.count - 1 { song = dataSource[songIndex - dataSource.count] }
        else if songIndex < 0 { song = dataSource[dataSource.count + songIndex] }
        else { song = dataSource[songIndex] }
        try? musicController.skip(nextSong: getAudioFile())
        if !paused { try? musicController.play() }
    }
    
    private func getAudioFile() throws -> AVAudioFile {
        return try AVAudioFile.init(forReading: self.song?.url ?? self.dataSource[0].url)
    }
}
