//
//  TopBar.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 23/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct TopBar: View {
    let pageTitle: String
    
    @ObservedObject var viewRouter: ViewRouter
    
    private let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(pageTitle)
                    .foregroundColor(Color.white)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Spacer()
                Image(systemName: "person.circle")
                    .font(.system(size: 25, weight: .regular))
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        self.viewRouter.currentView = "profile"
                }
//                .padding(.trailing, 20)
            }
            .padding(.horizontal, 35)
//            .padding(.leading, 20)
            .padding(.top, 50)
            .background(Color("top").opacity(0.01))
            
            Rectangle()
                .frame(width: self.screenWidth, height: 1.0, alignment: .bottom)
                .foregroundColor(.white)
        }.padding(.horizontal)
        .background(Color.gray.opacity(0.15))
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            TopBar(pageTitle: "Test", viewRouter: ViewRouter())
        }
    }
}
