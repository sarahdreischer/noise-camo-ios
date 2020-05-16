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
//        NavigationView {
            ZStack {
                BackgroundView()
                
                VStack(alignment: .center) {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                         HStack(alignment: .top, spacing: 0) {
                             ForEach(0..<sections.count) { index in
                                 ZStack {
                                     Rectangle()
                                         .foregroundColor(.gray)
                                         .cornerRadius(15)
                                         .frame(width: 150, height: 150)
                                         .padding(5)
                                     
                                     Text(self.sections[index])
                                 }
                             }
                         }
                    }
                    
                    NavigationLink(destination: EqualizerView()) {
                        EqualizerButtonView()
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .padding(10)
                    }
                    
                    Spacer()
                }
            }
        .navigationBarTitle("NOISE CAMO")
        .navigationBarItems(trailing:
            HStack {
                NavigationLink(destination: EqualizerView()) {
                   Image(systemName: "person.circle")
                    .font(.system(size: 30, weight: .regular))
                    .padding(.trailing, 20)
                    .foregroundColor(.white)
                }
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
