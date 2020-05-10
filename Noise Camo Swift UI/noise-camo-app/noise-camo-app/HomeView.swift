//
//  ContentView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 27/04/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    init() {
        UINavigationBar
            .appearance()
            .largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar
            .appearance()
            .titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center) {
                    
                    NavigationLink(destination: EqualizerView()) {
                        EqualizerButtonView()
                            .foregroundColor(.white)
                            .frame(height: 300)
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
                })
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
