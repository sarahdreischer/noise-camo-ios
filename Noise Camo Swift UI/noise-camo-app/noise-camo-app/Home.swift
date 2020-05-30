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
            
            HStack {
                Spacer()
                Image(systemName: "headphones")
                    .font(.system(size: 100,
                                  weight: .light))
                    .foregroundColor(.white)
                    .brightness(0.1)
                    .padding(.top, -20)
                
                Spacer()
                VStack(alignment: .leading) {
                    Image(systemName: "battery.25")
                        .font(.system(size: 32,
                                      weight: .regular))
                        .foregroundColor(.green)
                        .padding(.bottom, 10)
                    Text("25%")
                        .font(.system(size: 20,
                                      weight: .bold))
                        .foregroundColor(.white)
                }
                Spacer()
            }.frame(height: screenHeight/5)
            
            HStack {
                HomeButton(backgroundColor: Color.orange, navigateToView: "equalizer", imageName: "slider.horizontal.3", viewRouter: self.viewRouter)
                
                Spacer(minLength: 10)
                
                HomeButton(backgroundColor: Color.blue, navigateToView: "player", imageName: "play.fill", viewRouter: self.viewRouter)
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
    let imageName: String
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        Button(action: {
            self.viewRouter.currentView = self.navigateToView
        }) {
            HStack {
                Spacer()
                VStack {
                    Image(systemName: imageName)
                        .font(.system(size: 30,
                                      weight: .regular))
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    
                    Text(self.navigateToView.uppercased())
                       .foregroundColor(.white)
                }
                Spacer()
            }
            .frame(height: UIScreen.main.bounds.height/8)
            .background(backgroundColor.brightness(0.1))
            .cornerRadius(5)
        }
    }
}
