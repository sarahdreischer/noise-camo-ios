//
//  PageButtons.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 31/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct PageButtons: View {
    @ObservedObject var viewRouter: ViewRouter
    var body: some View {
        HStack(spacing: 10) {
            HomeButton(backgroundColor: Color("gray"), navigateToView: "equalizer", imageName: "slider.horizontal.3", viewRouter: self.viewRouter)
            
            HomeButton(backgroundColor: Color("gray"), navigateToView: "player", imageName: "play.fill", viewRouter: self.viewRouter)
        }
    }
}
struct PageButtons_Previews: PreviewProvider {
    static var previews: some View {
        PageButtons(viewRouter: ViewRouter())
    }
}
