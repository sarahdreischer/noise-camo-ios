//
//  PlayerViewModel.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 14/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class PlayerViewModel: ObservableObject, Identifiable {
    @Published var song: MusicAssetViewModel?
    
    @Published var dataSource: [MusicAssetViewModel] = []
    
    private let musicFetcher: MusicFetchable
    
    private let musicController: MusicControllable
    
    private var disposables = Set<AnyCancellable>()
    
    private let songs = ["song", "bad", "black"]
    
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
//        let index = dataSource.firstIndex { $0 as AnyObject === song as AnyObject }
        let index = 0
        try? musicFetcher.initPlayerEngine(forSong: songs[index])
    }
    
    func play() {
        try? musicController.play()
        print("\(String(describing: song?.title)) is playing")
    }
    
    func pause() {
        musicController.pause()
        print("\(String(describing: song?.title)) is paused")
    }
    
    func backward(_ sec: Int = 0) {
        print("Go backward by \(sec) seconds")
    }
    
    func forward(_ sec: Int = 0) {
        print("Go forward by \(sec) seconds")
    }
}
