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
            Color.black.edgesIgnoringSafeArea(.all)
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.dataSource.first?.title ?? "no title")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.top)
                    Text(viewModel.dataSource.first?.artist ?? "no artist")
                        .font(.caption)
                        .foregroundColor(Color("gray-1"))
                        .padding(.top)
                }.padding(.leading, 30)
                Spacer()
            }
        }
    }
}

//struct PlayerView_Previews: PreviewProvider {
//    let musicFetcher = MusicFetcher()
//    let viewModel: PlayerViewModel
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
