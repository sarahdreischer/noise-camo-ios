//
//  GridStack.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 11/05/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let columns: Int
    var value: Dictionary<String, Any>
    let sortedKeys: Array<String>
    let content: (String, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<self.value.keys.count/self.columns) { row in
                HStack {
                    ForEach(0..<self.columns) { column in
                        self.content(self.sortedKeys[row * self.columns + column], column)
                    }
                }
            }
        }
    }

    init(value: Dictionary<String, Any>, columns: Int, @ViewBuilder content: @escaping (String, Int) -> Content) {
        self.value = value
        sortedKeys = value.keys.sorted(by: <)
        self.columns = columns
        self.content = content
    }
}
