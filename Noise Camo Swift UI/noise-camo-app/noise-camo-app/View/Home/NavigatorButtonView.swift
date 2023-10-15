//
//  NavigatorButtonView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 07/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct NavigatorButtonsView: View {
    var body: some View {
        VStack(spacing: 1) {
            HStack(spacing: 1) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .opacity(0.15)
                    Text("equalizer")
                }
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .opacity(0.15)
                    Text("equalizer")
                }
            }
            
            HStack(spacing: 1) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .opacity(0.15)
                    Text("equalizer")
                }
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .opacity(0.15)
                    Text("equalizer")
                }
            }
        }
        .frame(height: UIScreen.main.bounds.height/3)
    }
}

struct NavigatorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatorButtonsView().background(Color.black)
    }
}

