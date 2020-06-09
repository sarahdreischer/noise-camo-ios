//
//  MediaPlayerView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 16/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI
import AVKit

struct MediaPlayerView: View {
    
    @EnvironmentObject var eqService: EqualizerService
    @ObservedObject var songModel: SongViewModel
 
    private let screenWidth = UIScreen.main.bounds.width - 50
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            Image(uiImage: (self.songModel.songs[self.songModel.currentSongIndex].audioArtwork?.count == 0) ?
                UIImage(named: "itunes")! :
                UIImage(data: self.songModel.songs[self.songModel.currentSongIndex].audioArtwork!)!)
                .resizable()
                .frame(width: self.songModel.songs[self.songModel.currentSongIndex].audioArtwork?.count == 0 ? 250 : nil, height: 250)
                .cornerRadius(15)
            
            ArtistInfoView(songModel: self.songModel)
            
            SongBar(songModel: self.songModel)
            
            SongNavigator(songModel: self.songModel)
            
            Spacer()
         
        }
        .scaleEffect(0.9)
        .onAppear {
            self.eqService.setBands(bands: self.eqService.equalizer.bands)
            self.songModel.attachEqualizer(equalizer: self.eqService.equalizer)
        }
    }
}

struct MediaPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            MediaPlayerView(songModel: SongViewModel())
                .environmentObject(EqualizerService())
        }
    }
}
