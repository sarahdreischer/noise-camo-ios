//
//  NavigationBarAppearance.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 21/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct CustomNavigationBar {
    
    let appearance: UINavigationBarAppearance
    
    init(_ color: UIColor) {
        appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        // this only applies to big titles
        appearance.largeTitleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 40), NSAttributedString.Key.foregroundColor : color
        ]
        
        // this only applies to small titles
        appearance.titleTextAttributes = [.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().tintColor = color
    }
}
