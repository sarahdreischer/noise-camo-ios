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
    
    var body: some View {
        HStack {
            Text(pageTitle)
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Button(action: {
                
            }) {
                Image(systemName: "person")
                    .font(.system(size: 32, weight: .regular))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 35)
        .padding(.top, 60)
        .padding(.bottom, 50)
        .background(Color("top"))
        .clipShape(Corners(corner: .bottomRight, size: CGSize(width: 50, height: 50)))
        .edgesIgnoringSafeArea(.all)
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar(pageTitle: "Test")
    }
}
