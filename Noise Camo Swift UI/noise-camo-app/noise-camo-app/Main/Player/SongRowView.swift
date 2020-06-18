//
//  SongRow.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 18/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct SongRowView: View {
    
    @State var tapped: Bool = false
    
    var musicAsset: MusicAssetViewModel
    
    var body: some View {
        HStack {
            Image(uiImage: musicAsset.artwork.count == 0 ?
                UIImage(named: "itunes")! :
                UIImage(data: musicAsset.artwork)!)
                .resizable()
                .frame(width: 50, height: 50)
            
            Text(musicAsset.title)
                .foregroundColor(.white)
            
            Spacer()
        }
    }
}

struct SongRow_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            SongRowView(musicAsset: MusicAssetViewModel(item: MusicFetcher().mockTrack()))
        }
    }
}
