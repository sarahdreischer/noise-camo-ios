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
                HomeView()
                    .modifier(PageViewWrapper(pageIndex: $index, pageTitle: "Home"))
            } else if index == 1 {
                EqualizerView()
                    .modifier(PageViewWrapper(pageIndex: $index, pageTitle: "Equalizer"))
            } else {
                MediaPlayerView()
                    .modifier(PageViewWrapper(pageIndex: $index, pageTitle: "Media Player"))
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
