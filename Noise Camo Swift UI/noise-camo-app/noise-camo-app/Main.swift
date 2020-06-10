//
//  GlobalTabView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 09/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct Main: View {
    
    @ObservedObject var viewRouter = ViewRouter()
    @ObservedObject var songModel: SongViewModel
    @ObservedObject var bluetoothManager: BluetoothManager
    
    fileprivate func addPageBars(pageTitle: String) -> PageViewWrapper {
        return PageViewWrapper( pageTitle: pageTitle, viewRouter: self.viewRouter)
    }
    
    var body: some View {
        VStack {
            if self.viewRouter.currentView == "home" {
                HomeView(bluetoothManager: self.bluetoothManager, viewRouter: self.viewRouter)
                    .modifier(addPageBars(pageTitle: "HOME"))
            } else if self.viewRouter.currentView == "equalizer" {
                EqualizerView()
                    .modifier(addPageBars(pageTitle: "EQUALIZER"))
            } else if self.viewRouter.currentView == "player" {
                MediaPlayerView(songModel: songModel)
                    .modifier(addPageBars(pageTitle: "PLAYER"))
            } else {
                Profile()
                    .modifier(addPageBars(pageTitle: "PROFILE"))
            }
        }
    }
}

struct GlobalTabView_Previews: PreviewProvider {
    static let eqService = EqualizerService()
    static var previews: some View {
        Main(songModel: SongViewModel(), bluetoothManager: BluetoothManager()).environmentObject(eqService)
    }
}
