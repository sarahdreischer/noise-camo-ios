//
//  Array+Filter.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 19/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import Foundation

public extension Array where Element: Hashable {
    static func removeDuplicates(_ elements: [Element]) -> [Element] {
        var seen = Set<Element>()
        return elements.filter{ seen.insert($0).inserted }
    }
}
