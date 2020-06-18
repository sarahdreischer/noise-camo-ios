//
//  PlayerView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 14/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var viewModel: PlayerViewModel
    
    init(viewModel: PlayerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color("music-background").edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                musicImage
                
                HStack {
                    musicInformation
                    Spacer()
                }
            }
        }
    }
}

private extension PlayerView {
    var musicImage: some View {
        Image(uiImage: (viewModel.song?.artwork.count == 0 ?
            UIImage(named: "itunes")! :
            UIImage(data: viewModel.song!.artwork))!)
        .resizable()
        .frame(width: viewModel.song?.artwork.count == 0 ? 250 : nil, height: 250)
        .cornerRadius(15)
    }
    
    var musicInformation: some View {
        VStack(alignment: .leading) {
            Text(viewModel.song?.title ?? "no title")
                .font(.title)
                .foregroundColor(.white)
                .padding(.top)
            Text(viewModel.song?.artist ?? "no artist")
                .font(.caption)
                .foregroundColor(Color("gray-1"))
                .padding(.top)
        }.padding(.leading, 30)
    }
}

//struct PlayerView_Previews: PreviewProvider {
//    let musicFetcher = MusicFetcher()
//    var viewModel: PlayerViewModel
//    init() {
//        viewModel = PlayerViewModel(musicFetcher: musicFetcher)
//    }
//    static var previews: some View {
//        ZStack {
//            Color.black.edgesIgnoringSafeArea(.all)
//            PlayerView(viewModel: self.viewModel)
//        }
//    }
//}
