//
//  PageViewWrapper.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 16/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct PageViewWrapper: ViewModifier {
    
    let pageTitle: String
    @ObservedObject var viewRouter: ViewRouter
    
    func body(content: Content) -> some View {
        ZStack {
            BackgroundView()
            VStack {
                TopBar(pageTitle: pageTitle, viewRouter: viewRouter)
                content.padding(30)
                TapBar(viewRouter: self.viewRouter)
            }.edgesIgnoringSafeArea(.vertical)
        }
    }
}
