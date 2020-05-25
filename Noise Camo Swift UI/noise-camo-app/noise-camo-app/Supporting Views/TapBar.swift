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
        HStack {
        
            Button(action: {
                self.index.wrappedValue = 0
            }) {
                VStack {
                    Image(systemName: "house")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white)
                        .padding()
                        .background((index.wrappedValue == 0) ? Color.orange : Color("top"))
                        .clipShape(Circle())
                        .padding(5)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.5), lineWidth: 2)
                        )
                }.padding()
            }
            
            Spacer(minLength: 15)

            Button(action: {
                self.index.wrappedValue = 1
            }) {
                VStack {
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                        .padding()
                        .background((index.wrappedValue == 1) ? Color.orange : Color("top"))
                        .
                        clipShape(Circle())
                        .padding(5)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.5), lineWidth: 2)
                        )
                }
                .padding()
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                self.index.wrappedValue = 2
            }) {
                VStack {
                    Image(systemName: "music.note")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white)
                        .padding()
                        .background((index.wrappedValue == 2) ? Color.orange : Color("top"))
                        .
                        clipShape(Circle())
                        .padding(5)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.5), lineWidth: 2)
                        )
                }.padding()
            }
            
            
        }
        .padding(.top, -30)
        .padding(.horizontal, 25)
        .background(Color.gray.opacity(0.1))
        .animation(.spring())
    }
}

struct TapBar_Previews: PreviewProvider {
    static var previews: some View {
        TapBar(index: Binding.constant(2))
    }
}
