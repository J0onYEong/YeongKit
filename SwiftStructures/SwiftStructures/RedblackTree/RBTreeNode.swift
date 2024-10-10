//
//  RBTreeNode.swift
//  SwiftStructures
//
//  Created by choijunios on 10/10/24.
//

import Foundation

public class RBTreeNode<Value> where Value: Comparable {
    
    typealias Node = RBTreeNode<Value>
    
    public enum NodeColor {
        case red
        case black
    }
    
    // Node information
    public let value: Value?
    var color: NodeColor
    
    // Parent node
    var parent: Node? = nil
    
    // Children nodes
    var leftChild: Node
    var rightChild: Node
    
    var isEmptyNode: Bool {
        value == nil
    }
    
    init(value: Value?, color: NodeColor, parent: Node? = nil) {
        self.value = value
        self.color = color
        self.parent = parent
        self.leftChild = .emptyLeafNode
        self.rightChild = .emptyLeafNode
        
        // set parent
        leftChild.parent = self
        rightChild.parent = self
    }
    
    /// Set a node to child
    func setToChild(_ node: Node) {
        node.parent = self
        
        if node.value! > self.value! {
            self.rightChild = node
        } else if node.value! < self.value! {
            self.leftChild = node
        } else {
            fatalError("BST node's values should be unique")
        }
    }
    
    /// Find sibiling node
    func getSibilingNode(_ node: Node) -> Node {
        
        if leftChild === node {
            return rightChild
            
        } else if rightChild === node {
            return leftChild
            
        } else {
            fatalError("\(#function) this isn't child of current node")
        }
    }
}

private extension RBTreeNode {
    
    /// A basic leaf node with no value and a default black color.
    static var emptyLeafNode: Node {
        .init(value: nil, color: .black)
    }
}

extension RBTreeNode: Comparable {
    
    public static func == (lhs: RBTreeNode<Value>, rhs: RBTreeNode<Value>) -> Bool {
        lhs.value! == rhs.value!
    }
    
    public static func < (lhs: RBTreeNode<Value>, rhs: RBTreeNode<Value>) -> Bool {
        lhs.value! < rhs.value!
    }
}
