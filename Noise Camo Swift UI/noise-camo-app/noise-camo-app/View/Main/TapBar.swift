//
//  TapBar.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 24/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct TapBar: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        HStack {
            TapButton(systemImageName: "house", navigateToView: "home", viewRouter: self.viewRouter)
            
            Spacer(minLength: 10)
            
            TapButton(systemImageName: "slider.horizontal.3", navigateToView: "equalizer", viewRouter: self.viewRouter)
            
            Spacer(minLength: 10)
            
            TapButton(systemImageName: "music.note", navigateToView: "player", viewRouter: self.viewRouter)
            
            Spacer(minLength: 10)
            
            TapButton(systemImageName: "person", navigateToView: "profile", viewRouter: self.viewRouter)
            
        }
        .padding(.bottom, 20)
        .padding(.horizontal, 25)
        .animation(.spring())
        .background(Color("background").opacity(0.2))
    }
}

struct TapBar_Previews: PreviewProvider {
    static var previews: some View {
        TapBar(viewRouter: ViewRouter())
    }
}

struct TapButton: View {
    var systemImageName: String
    var navigateToView: String
    
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Image(systemName: self.systemImageName)
                .font(.system(size: (self.viewRouter.currentView == navigateToView) ? 16 : 16, weight: .regular))
               .foregroundColor(.white)
               .padding()
               .background((self.viewRouter.currentView == navigateToView) ? Color("background") : Color("gray"))
               .clipShape(Circle())
               .padding(5)
               .shadow(radius: 5)
       }.padding()
        .shadow(radius: 5)
            .onTapGesture {
                self.viewRouter.currentView = self.navigateToView
        }
    }
}
