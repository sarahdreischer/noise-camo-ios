//
//  PageViewWrapper.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 16/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct PageViewWrapper: View {
    let view: UIView
    var body: some View {
        ZStack {
            BackgroundView()
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.4)
                self.view
                
            }
            .cornerRadius(20)
            .padding()
        }
    }
}

struct PageViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        PageViewWrapper(view: HomeView())
    }
}
