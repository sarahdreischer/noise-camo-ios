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
    let value: Dictionary<String, Any>
    let content: (String, Int) -> Content
    
    private var rows: Int
    private let remainder: Int
    

    var body: some View {
        VStack {
            ForEach(value.keys.sorted(), id: \.self) { key in
                HStack(spacing: 20) {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        self.content(key, column)
                    }
                }
            }
        }
    }

    init(value: Dictionary<String, Any>, columns: Int, @ViewBuilder content: @escaping (String, Int) -> Content) {
        self.value = value
        self.columns = columns
        self.content = content
        
        rows = self.value.keys.count / columns
        remainder = self.value.keys.count % columns
        if remainder > 0 { rows += rows }
    }
}
