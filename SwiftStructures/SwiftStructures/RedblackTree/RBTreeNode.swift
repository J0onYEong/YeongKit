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
    var color: NodeColor
    
    // Parent node
    var parent: RBTreeNode<Value>? = nil
    
    // Children nodes
    var leftChild: RBTreeNode<Value>
    var rightChild: RBTreeNode<Value>
    
    init(value: Value?, color: NodeColor, parent: RBTreeNode<Value>? = nil) {
        self.value = value
        self.color = color
        self.parent = parent
        self.leftChild = .emptyLeafNode
        self.rightChild = .emptyLeafNode
        
        // set parent
        leftChild.parent = self
        rightChild.parent = self
    }
    
    func setToChild(_ node: RBTreeNode<Value>) {
        node.parent = self
        
        if node.value! > self.value! {
            self.rightChild = node
        } else if node.value! < self.value! {
            self.leftChild = node
        } else {
            fatalError("BST node's values should be unique")
        }
    }
}

private extension RBTreeNode {
    
    /// A basic leaf node with no value and a default black color.
    static var emptyLeafNode: RBTreeNode<Value> {
        .init(value: nil, color: .black)
    }
}
