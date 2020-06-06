//
//  SongBar.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 03/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct SongBar: View {
    @ObservedObject var songModel: SongViewModel
    private let screenWidth = UIScreen.main.bounds.width - 50

    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color.white.opacity(0.6))
                .frame(width: self.screenWidth, height: 8)
            Capsule()
                .fill(Color("top"))
                .frame(width: CGFloat(self.songModel.songBarWidthFactor) * screenWidth, height: 8)
                .gesture(DragGesture()
                    .onChanged({ value in
                        let x = value.location.x
                        self.songModel.songBarWidthFactor = Double(x / self.screenWidth)
                    }).onEnded({ (value) in
                        let factor = value.location.x / self.screenWidth
                        let time = Double(factor) * self.songModel.songs[self.songModel.currentSongIndex].duration
                        self.songModel.seekTo(time)
                    }))
        }
        .padding(.top)
        .onReceive(songModel.timer) { _ in
            self.songModel.checkIfSongFinished()
            self.songModel.updatePlayingTime()
            self.songModel.updateSongBarWidthFactor()
        }
    }
}


struct SongBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            SongBar(songModel: SongViewModel())
        }
    }
}
