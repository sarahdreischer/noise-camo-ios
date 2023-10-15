//
//  ArtistInfo.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 03/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct ArtistInfoView: View {
    @ObservedObject var songModel: SongViewModel
    
    private let screenWidth = UIScreen.main.bounds.width - 50
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.songModel.songs[self.songModel.currentSongIndex].audioTitle!)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .padding(.top)
                Text(self.songModel.songs[self.songModel.currentSongIndex].audioArtist!)
                    .font(.system(size: 16))
                    .foregroundColor(Color("gray-1"))
                    .padding(.top)
            }.padding(.leading, 30)
            Spacer()
        }
    }
}

//struct ArtistInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
