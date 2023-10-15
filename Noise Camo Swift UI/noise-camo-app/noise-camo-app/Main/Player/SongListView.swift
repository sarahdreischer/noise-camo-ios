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
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                TitleView(title: "Songs")
                
                List(viewModel.dataSource, id: \.id) { music in
                    SongRowView(musicAsset: music)
                        .onTapGesture(perform: {
                            self.viewModel.song = music
                            self.tapped.toggle()
                        })
                        .sheet(isPresented: self.$tapped) {
                            PlayerView(viewModel: self.viewModel)
                                .shadow(radius: 2)
                    }
                }.listRowBackground(Color.black)
            }
        }
    }
    
    init(viewModel: PlayerViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().separatorStyle = .singleLine
        UITableViewCell.appearance().backgroundColor = .black
        UITableView.appearance().backgroundColor = .black
    }
}
