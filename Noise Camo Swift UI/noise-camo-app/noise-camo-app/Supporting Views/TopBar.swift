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
    
    private let screenWidth = UIScreen.main.bounds.width - 40
    
    var body: some View {
        VStack {
            HStack {
                Text(pageTitle)
                    .foregroundColor(Color("gray-1"))
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.leading, 10)
                
                Spacer()
                
//                Button(action: {
//                    
//                }) {
                    Image(systemName: "person.circle")
                        .font(.system(size: 26, weight: .regular))
                        .foregroundColor(Color("gray-1"))
                        .onTapGesture {
                            self.viewRouter.currentView = "profile"
                    }
//                }
            }
            .padding(.horizontal, 35)
            .padding(.top, 50)
            .background(Color("top").opacity(0.01))
            
            Rectangle()
                .frame(width: self.screenWidth, height: 1.0, alignment: .bottom)
                .foregroundColor(.white)
        }.padding(.horizontal)
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
