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
                content.padding(30).edgesIgnoringSafeArea(.vertical)
                Spacer()
                TapBar(viewRouter: self.viewRouter)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
