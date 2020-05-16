//
//  PageViewWrapper.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 16/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct PageViewWrapper: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            BackgroundView()
            ZStack {
                Rectangle()
                .foregroundColor(.black)
                .opacity(0.4)
                
                content
            }
            .cornerRadius(20)
            .padding()
        }
    }
}
