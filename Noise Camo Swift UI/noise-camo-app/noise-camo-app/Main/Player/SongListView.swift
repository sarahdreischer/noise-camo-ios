//
//  SongListView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 18/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct SongListView: View {
    @ObservedObject var viewModel: PlayerViewModel
    
    @State var tapped: Bool = false
    
    var body: some View {
        List(viewModel.dataSource, id: \.id) { music in
            SongRowView(musicAsset: music)
                .onTapGesture(perform: {
                    self.viewModel.song = music
                    self.tapped.toggle()
                })
                .sheet(isPresented: self.$tapped) {
                    PlayerView(viewModel: self.viewModel)
                }
        }.listRowBackground(Color.black)
    }
    
    init(viewModel: PlayerViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .black
        UITableView.appearance().backgroundColor = .black
    }
}


//struct SongListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SongListView()
//    }
//}
