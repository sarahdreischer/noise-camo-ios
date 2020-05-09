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
            Rectangle()
                .fill(LinearGradient(
                    gradient: .init(colors: [Self.gradientPoint1, Self.gradientPoint2, Self.gradientPoint3, Self.gradientPoint4]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 1)))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
            .fill(LinearGradient(
                gradient: .init(colors: [Self.gradientPoint4, Self.gradientPoint3, Self.gradientPoint2, Self.gradientPoint1]),
            startPoint: .init(x: 0.5, y: 0),
            endPoint: .init(x: 0.5, y: 1)))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
