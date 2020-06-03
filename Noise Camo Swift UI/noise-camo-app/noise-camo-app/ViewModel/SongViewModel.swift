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
        asset.commonMetadata.forEach { attribute in
            if attribute.commonKey?.rawValue == "artwork" { songArtwork = attribute.value as! Data }
            else if attribute.commonKey?.rawValue == "title" { songTitle = attribute.value as! String }
            else if attribute.commonKey?.rawValue == "artist" { songArtist = attribute.value as! String }
        }
    }
    
    public func resetCurrentSong() {
        print("Resetting \(String(describing: songs[currentSongIndex].audioTitle))")
        songs[currentSongIndex].reset()
    }
    
    public func updateDuration() {
        songs[currentSongIndex].duration = songs[currentSongIndex].length / songs[currentSongIndex].sampleRate
    }
}
