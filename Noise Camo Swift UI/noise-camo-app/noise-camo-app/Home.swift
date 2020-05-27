//
//  GlobalTabView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 09/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var index: Int = 0
    
    var body: some View {
        ZStack {
            if index == 0 {
                HomeView(pageIndex: self.$index)
                    .modifier(PageViewWrapper(pageIndex: $index, pageTitle: "HOME"))
            } else if index == 1 {
                EqualizerView()
                    .modifier(PageViewWrapper(pageIndex: $index, pageTitle: "EQUALIZER"))
            } else {
                MediaPlayerView()
                    .modifier(PageViewWrapper(pageIndex: $index, pageTitle: "PLAYER"))
            }
        }
    }
}

struct GlobalTabView_Previews: PreviewProvider {
    static let audioSerivce = AudioService()
    static let eqService = EqualizerService()
    static var previews: some View {
        Home()
            .environmentObject(audioSerivce)
            .environmentObject(eqService)
    }
}

struct InstructionCard: View {
    var body: some View {
        ZStack {
            BackgroundView()
            Text("Set up bluetooth on your device")
                .foregroundColor(.white)
        }
    }
}
