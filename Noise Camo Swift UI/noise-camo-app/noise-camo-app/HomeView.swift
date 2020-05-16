//
//  ContentView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 27/04/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    let sections = ["instructions", "music player", "blog"]
    
    init() {
        UINavigationBar
            .appearance()
            .largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar
            .appearance()
            .titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            ZStack {
                Rectangle()
                .foregroundColor(.black)
                .opacity(0.4)
                
                VStack(alignment: .center) {
                    Text("Set up your device")
                        .foregroundColor(.white)
                    
                }
            }
            .cornerRadius(20)
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
