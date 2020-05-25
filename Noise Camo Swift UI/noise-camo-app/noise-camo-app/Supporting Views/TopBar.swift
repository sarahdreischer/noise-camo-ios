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
    
    private let screenWidth = UIScreen.main.bounds.width - 30
    
    var body: some View {
        VStack {
            HStack {
                Text(pageTitle)
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Image(systemName: "person.circle")
                        .font(.system(size: 26, weight: .regular))
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 35)
            .padding(.top, 50)
//            .padding(.bottom,)
            .background(Color("top").opacity(0.01))
            
            Rectangle()
                .frame(width: self.screenWidth, height: 1.0, alignment: .bottom)
                .foregroundColor(Color("gray"))
        }
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            TopBar(pageTitle: "Test")
        }
    }
}
