//
//  RBTreeNode.swift
//  SwiftStructures
//
//  Created by choijunios on 10/10/24.
//

import Foundation

public class RBTreeNode<Value> where Value: Comparable {
    
    public enum NodeColor {
        case red
        case black
    }
    
    // Node information
    public let value: Value?
    public private(set) var color: NodeColor
    
    // Children
    var leftChild: RBTreeNode<Value>
    var rightChild: RBTreeNode<Value>
    
    init(value: Value?, color: NodeColor) {
        self.value = value
        self.color = color
        self.leftChild = .emptyLeafNode
        self.rightChild = .emptyLeafNode
    }
}

private extension RBTreeNode {
    
    /// A basic leaf node with no value and a default black color.
    static var emptyLeafNode: RBTreeNode<Value> {
        .init(value: nil, color: .black)
    }
}
