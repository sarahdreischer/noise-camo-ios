//
//  SingleNavigatorButtonView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 07/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct SingleNavigatorButtonView: View {
    var buttonText: String
    var imageName: String
    var isSystemName: Bool
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("background"))
                    .frame(width: UIScreen.main.bounds.width/3.5, height: UIScreen.main.bounds.height/7)
                    .cornerRadius(15)
                
                VStack {
                    ZStack {
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 50, height: 50)
                        Image(systemName: imageName)
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(Color("background"))
                        }
                
                    Text(buttonText)
                        .foregroundColor(.white)
                        .font(.callout)
                    
                }
                
            }.shadow(color: Color("gray").opacity(0.6), radius: 1, x: 1, y: 1)
            
        }
        .padding(.vertical)
    }
}

struct SingleNavigatorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SingleNavigatorButtonView(buttonText: "equalizer", imageName: "slider.horizontal.3", isSystemName: true)
            .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/6)
            .background(Color.gray)
    }
}
