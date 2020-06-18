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
                
                musicInformation.padding(.bottom, 20)
                
                musicNavigator
            }
        }.onAppear {
            self.viewModel.initialisePlayerNode()
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
        .padding(.horizontal)
    }
    
    var musicInformation: some View {
        VStack(alignment: .center) {
            Text(viewModel.song?.title ?? "no title")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.top)
            Text(viewModel.song?.artist ?? "no artist")
                .font(.caption)
                .foregroundColor(Color("gray-1"))
                .padding(.top)
        }
    }
    
    var musicNavigator: some View {
        HStack(spacing: 20) {
            Button(action: {
                self.viewModel.backward()
            }) {
                Image(systemName: "backward")
                    .font(.system(size: 30, weight: .regular))
                    .foregroundColor(.white)
            }
            
            Button(action: {
                self.viewModel.backward(15)
            }) {
                Image(systemName: "gobackward.15")
                    .font(.system(size: 30, weight: .regular))
                    .foregroundColor(.white)
            }
            
            Button(action: {
                self.viewModel.play()
            }) {
                Image(systemName: "play")
                    .font(.system(size: 50, weight: .regular))
                    .foregroundColor(.white)
            }
            
            Button(action: {
                self.viewModel.forward(15)
            }) {
                Image(systemName: "goforward.15")
                    .font(.system(size: 30, weight: .regular))
                    .foregroundColor(.white)
            }
            
            Button(action: {
                self.viewModel.forward()
            }) {
                Image(systemName: "forward")
                    .font(.system(size: 30, weight: .regular))
                    .foregroundColor(.white)
            }
        }
    }
}
