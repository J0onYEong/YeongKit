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
    var leftChild: Node? = nil
    var rightChild: Node? = nil
    
    var isEmptyNode: Bool {
        value == nil
    }
    
    init(value: Value?, color: NodeColor, parent: Node? = nil) {
        self.value = value
        self.color = color
        self.parent = parent
        if value != nil {
            self.leftChild = makeEmptyLeafNode()
            self.rightChild = makeEmptyLeafNode()
        }
    }
    
    /// Set a node to child
    func setToChild(_ node: Node) {
        node.parent = self
        
        if node > self {
            self.rightChild = node
        } else if node < self {
            self.leftChild = node
        } else {
            fatalError("BST node's values should be unique")
        }
    }
    
    /// Find sibiling node
    func getSibilingNode(_ node: Node) -> Node {
        
        if leftChild === node {
            return rightChild!
            
        } else if rightChild === node {
            return leftChild!
            
        } else {
            fatalError("\(#function) this isn't child of current node")
        }
    }
    
    func removeChild(_ node: Node) {
        if leftChild === node {
            leftChild = makeEmptyLeafNode()
            node.parent = nil
            
        } else if rightChild === node {
            rightChild = makeEmptyLeafNode()
            node.parent = nil
            
        } else {
            fatalError("\(#function) this isn't child of current node")
        }
    }
}

private extension RBTreeNode {
    
    /// A basic leaf node with no value and a default black color.
    func makeEmptyLeafNode() -> Node {
        let leafNode: Node = .init(value: nil, color: .black)
        leafNode.parent = self
        return leafNode
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
