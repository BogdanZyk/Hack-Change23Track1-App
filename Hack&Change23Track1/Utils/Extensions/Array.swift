//
//  Array.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 08.12.2023.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(s index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
