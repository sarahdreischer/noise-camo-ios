//
//  TapBar.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 24/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct TapBar: View {
    var index: Binding<Int>
    
    var body: some View {
        VStack {
            
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 1.0, alignment: .bottom)
                .foregroundColor(.white)
                .padding(.bottom)
            
            HStack {
                
                TapButton(systemImageName: "house", tapped: (self.index.wrappedValue == 0), action: {
                    self.index.wrappedValue = 0
                })
                
                Spacer(minLength: 10)
                
                TapButton(systemImageName: "slider.horizontal.3", tapped: (self.index.wrappedValue == 1), action: {
                    self.index.wrappedValue = 1
                })
                
                Spacer(minLength: 10)
                
                TapButton(systemImageName: "music.note", tapped: (self.index.wrappedValue == 2), action: {
                    self.index.wrappedValue = 2
                })
                
                Spacer(minLength: 10)
                
                TapButton(systemImageName: "person", tapped: (self.index.wrappedValue == 3), action: {
                    self.index.wrappedValue = 3
                })
            }
            .padding(.bottom, 20)
            .padding(.top, -30)
            .padding(.horizontal, 25)
    //        .background(Color.gray.opacity(0.1))
            .animation(.spring())
        }.background(Color.gray.opacity(0.1))
    }
}

struct TapBar_Previews: PreviewProvider {
    static var previews: some View {
        TapBar(index: Binding.constant(2))
    }
}

struct TapButton: View {
    var systemImageName: String
    var tapped: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            VStack {
                Image(systemName: self.systemImageName)
                    .font(.system(size: (self.tapped) ? 24 : 16, weight: .regular))
                   .foregroundColor(.white)
                   .padding()
                    .background((self.tapped) ? Color.orange : Color("gray"))
                   .
                   clipShape(Circle())
                   .padding(5)
           }.padding()
            .shadow(radius: 5)
        }
    }
}
