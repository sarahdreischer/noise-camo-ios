//
//  BackgroundView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 04/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct BackgroundView: View {
    static let gradientPoint1 = Color(red: 0.44, green: 0.44, blue: 0.44, opacity: 1.0)
    static let gradientPoint2 = Color(red: 0.77, green: 0.77, blue: 0.77, opacity: 0.77)
    static let gradientPoint3 = Color(red: 0.77, green: 0.77, blue: 0.77, opacity: 0.18)
    static let gradientPoint4 = Color(red: 0.77, green: 0.77, blue: 0.77, opacity: 0)
    
    var body: some View {
        ZStack {
            Color(.black)
                .edgesIgnoringSafeArea(.all)
            
            LinearGradient(
                gradient: .init(colors: [.blue, .black]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 0.3)
            )
                .opacity(0.4)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
