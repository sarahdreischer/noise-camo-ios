//
//  SongViewModel.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 31/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation
import AVFoundation

class SongViewModel: ObservableObject {
    @Published var songs = [SongModel]()
    @Published var currentSongIndex = 0
    
    init() {
        getSongs()
    }
    
    private func getSongs() {
        let songList = ["song", "black", "bad"]
        
        for song in songList {
            do {
                if let path = Bundle.main.path(forResource: song, ofType: "mp3") {
                    let url = NSURL.fileURL(withPath: path)
                    let audioFile = try AVAudioFile(forReading: url)
                    var songArtwork: Data = .init(count: 0)
                    var songTitle = ""
                    var songArtist = ""
                    let asset = AVAsset(url: url)
                    
                    extractAudioMetadata(asset, &songArtwork, &songTitle, &songArtist)
                    self.songs.append(
                        SongModel.init(audioFile: audioFile, audioArtwork: songArtwork, audioTitle: songTitle, audioArtist: songArtist, audioLength: Double(audioFile.length))
                    )
                    print("Current song index \(self.currentSongIndex)")
                    print("Current song \(self.songs[self.currentSongIndex])") 
                }
            } catch {
                print("Could not create audio file from \(song).mp3")
            }
        }
    }
    
    fileprivate func extractAudioMetadata(_ asset: AVAsset, _ songArtwork: inout Data, _ songTitle: inout String, _ songArtist: inout String) {
        for i in asset.commonMetadata {
            if i.commonKey?.rawValue == "artwork" { songArtwork = i.value as! Data }
            if i.commonKey?.rawValue == "title" { songTitle = i.value as! String }
            if i.commonKey?.rawValue == "artist" { songArtist = i.value as! String }
        }
    }
}
