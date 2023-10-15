//
//  TitleView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 27/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    let title: String
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
            }
            .padding(.top, 20)
            .padding(.bottom, 5)
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "test title").background(Color.black)
    }
}
