//
//  RBTree.swift
//  SwiftStructures
//
//  Created by choijunios on 10/10/24.
//

import Foundation

public class RBTree<Element> where Element: Comparable {
    
    private(set) var rootNode: RBTreeNode<Element>?
    
    public init(value: Element? = nil) {
        
        if let value {
            /// Root node is always black
            self.rootNode = .init(value: value, color: .black)
        }
    }
}
