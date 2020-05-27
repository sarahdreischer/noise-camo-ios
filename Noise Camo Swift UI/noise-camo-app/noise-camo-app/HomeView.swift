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
    
    var pageIndex: Binding<Int>
    
    var body: some View {        
        VStack(alignment: .center) {
            NavigationLink(destination:
            EqualizerView()
                .modifier(PageViewWrapper(pageIndex: self.pageIndex, pageTitle: "Equalizer"))) {
                HStack {
                       Text("Equalizer")
                           .foregroundColor(.white)
                   }
                   .frame(width: UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.height/4)
                   .background(Color("gray"))
                   .cornerRadius(25)
               }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            HomeView(pageIndex: Binding.constant(1))
        }
    }
}
