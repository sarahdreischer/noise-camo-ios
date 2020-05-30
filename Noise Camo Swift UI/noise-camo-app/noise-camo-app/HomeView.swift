//
//  ContentView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 27/04/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct Home: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {        
        VStack(alignment: .center) {
            
            Button(action: {
                self.viewRouter.currentView = "equalizer"
            }) {
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
            Home(viewRouter: ViewRouter())
        }
    }
}
