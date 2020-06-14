//
//  TopBar.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 07/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct TopBarView: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                self.viewRouter.currentView = "profile"
            }) {
                ZStack {
                    Circle().foregroundColor(.black)
                        .opacity(0.6)
                        .frame(width: 40, height: 40)
                        .shadow(color: Color("gray"), radius: 10, x: 1, y: 1)
                    
                    Image(systemName: "person.circle")
                    .font(.system(size: 25, weight: .regular))
                    .foregroundColor(Color.white)
                }
            }
        }.padding(.top, 40)
        .padding(.trailing, 20)
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView(viewRouter: ViewRouter())
            .background(Color("gray-1"))
    }
}
