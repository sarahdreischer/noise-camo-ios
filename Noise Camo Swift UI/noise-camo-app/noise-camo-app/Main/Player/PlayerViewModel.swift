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
    @Published var song: String = ""
    
    @Published var dataSource: [PlayerAssetViewModel] = []
    
    private let musicFetcher: MusicFetchable
    
    private var disposables = Set<AnyCancellable>()
    
    private let songs = ["song", "bad", "black"]
    
    init(musicFetcher: MusicFetchable) {
        self.musicFetcher = musicFetcher
        songs.forEach { fetchMusic(forSong: $0) }
        song = songs.first ?? ""
    }
    
    func fetchMusic(forSong song: String) {
        musicFetcher.track(forSong: song)
        .sink(receiveCompletion: { err in
            print(".sink() received the completion", String(describing: err))
        }, receiveValue: { asset in
            let playerViewModel = PlayerAssetViewModel(item: asset)
            print(playerViewModel.artist)
            self.dataSource.append(playerViewModel)
        })
        .store(in: &disposables)
    }
}
