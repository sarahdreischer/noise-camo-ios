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
    
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {        
        VStack(alignment: .center) {
            
            Image("earphone-background1")
                .brightness(0.1)
                .padding(.bottom, 10)
            
            HStack {
                HomeButton(backgroundColor: Color.orange, navigateToView: "equalizer", viewRouter: self.viewRouter)
                
                Spacer(minLength: 10)
                
                HomeButton(backgroundColor: Color.blue, navigateToView: "player", viewRouter: self.viewRouter)
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

struct HomeButton: View {
    
    let backgroundColor: Color
    let navigateToView: String
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        Button(action: {
            self.viewRouter.currentView = self.navigateToView
        }) {
            HStack {
                Spacer()
                Text(self.navigateToView.uppercased())
                   .foregroundColor(.white)
                Spacer()
            }
           .frame(height: UIScreen.main.bounds.height/8)
            .background(backgroundColor.brightness(0.1))
           .cornerRadius(5)
        }
    }
}
