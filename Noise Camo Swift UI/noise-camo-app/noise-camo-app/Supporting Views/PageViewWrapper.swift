//
//  PageViewWrapper.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 16/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct PageViewWrapper: ViewModifier {
    
    var pageIndex: Binding<Int>
    let pageTitle: String
    
    func body(content: Content) -> some View {
        ZStack {
            BackgroundView()
            VStack {
                TopBar(pageTitle: pageTitle)
                content.padding(30)
                TapBar(index: pageIndex)
            }.edgesIgnoringSafeArea(.vertical)
        }
    }
}
