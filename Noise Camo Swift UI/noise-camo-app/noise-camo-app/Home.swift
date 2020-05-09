//
//  ContentView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 27/04/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                VStack(alignment: .center) {
                    
                    NavigationLink(destination: EqualizerView()) {
                        
                        EqualizerButtonView()
                            .foregroundColor(.black)
                            .frame(height: 300.0)
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
                        .foregroundColor(.black)
                    }
                })
//            .navigationBarItems(leading:
//                HStack {
//                    Text("NOISE")
//                        .fontWeight(.regular)
//
//                    Text("CAMO")
//                    .fontWeight(.medium)
//                }.font(.title),
//            trailing:
//                HStack {
//                    NavigationLink(destination: EqualizerView()) {
//                       Image(systemName: "person.circle")
//                        .font(.system(size: 30, weight: .regular))
//                        .padding(.trailing, 20)
//                        .foregroundColor(.black)
//                    }
//                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
