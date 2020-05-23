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
    let screenWidth = UIScreen.main.bounds.width - 30
    
    func body(content: Content) -> some View {
        ZStack {
            BackgroundView()
            VStack {
                TopBar(pageTitle: pageTitle)
                content.padding()
                Spacer()
            }
        }
    }
}
