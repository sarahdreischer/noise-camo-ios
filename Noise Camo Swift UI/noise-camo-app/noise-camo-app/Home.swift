//
//  GlobalTabView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 09/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct Home: View {
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    var body: some View {
        TabView {
            HomeView()
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            EqualizerView()
            .tabItem {
                Image(systemName: "slider.horizontal.3")
                Text("EQ")
            }
        }
        .font(.system(size: 25))
    }
}

struct GlobalTabView_Previews: PreviewProvider {
    static let eqSettings = EqualizerSettings()
    static var previews: some View {
        Home().environmentObject(eqSettings)
    }
}
