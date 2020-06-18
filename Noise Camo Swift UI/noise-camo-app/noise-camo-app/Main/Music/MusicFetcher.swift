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
}

class MusicFetcher {
}

extension MusicFetcher: MusicFetchable {
    func track(forSong song: String) -> AnyPublisher<AVURLAsset, MusicError> {
        return makeTrack(forSong: song)
    }
    
    private func makeTrack(forSong song: String) -> AnyPublisher<AVURLAsset, MusicError> {
        guard let path = Bundle.main.path(forResource: song, ofType: "mp3") else {
            let error = MusicError.parsing(description: "Could not create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        let url = NSURL.fileURL(withPath: path)
        return Just(AVURLAsset(url: url, options: nil)).setFailureType(to: MusicError.self).eraseToAnyPublisher()
    }
    
    func mockTrack() -> AVURLAsset {
        let path = Bundle.main.path(forResource: "song", ofType: "mp3")
        let url = NSURL.fileURL(withPath: path!)
        return AVURLAsset(url: url, options: nil)
    }
}
