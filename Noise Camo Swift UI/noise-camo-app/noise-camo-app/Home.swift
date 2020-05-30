//
//  GlobalTabView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 09/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct Home: View {
    
    @ObservedObject var viewRouter = ViewRouter()
    
    var body: some View {
        VStack {
            if self.viewRouter.currentView == "home" {
                HomeView(viewRouter: self.viewRouter)
                    .modifier(PageViewWrapper( pageTitle: "HOME", viewRouter: self.viewRouter))
            } else if self.viewRouter.currentView == "equalizer" {
                EqualizerView()
                    .modifier(PageViewWrapper(pageTitle: "EQUALIZER", viewRouter: self.viewRouter))
            } else {
                MediaPlayerView()
                    .modifier(PageViewWrapper(pageTitle: "PLAYER", viewRouter: self.viewRouter))
            }
        }
    }
}

struct GlobalTabView_Previews: PreviewProvider {
    static let audioSerivce = AudioService()
    static let eqService = EqualizerService()
    static var previews: some View {
        Home(viewRouter: ViewRouter())
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
