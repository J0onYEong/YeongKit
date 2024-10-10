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
            createRoot(value)
        }
    }
    
    private func createRoot(_ value: Element) {
        // Root node is always black
        self.rootNode = .init(value: value, color: .black)
    }
    
    
    /// Append element to tree
    public func append(_ value: Element) {
        
        guard let rootNode else {
            // Root node is empty
            createRoot(value)
            return
        }
        
        // new node is always red
        let newNode: RBTreeNode = .init(value: value, color: .red)
        var currentParentNode: RBTreeNode! = rootNode
        
        while(true) {
            
            if currentParentNode.value == nil {
                // CurrentNode is empty leaf
                currentParentNode.parent?.setToChild(newNode)
                break
            }
            
            if currentParentNode.value! > newNode.value! {
                // go left
                currentParentNode = currentParentNode.leftChild
            } else if currentParentNode.value! < newNode.value! {
                // go right
                currentParentNode = currentParentNode.rightChild
            } else {
                fatalError("BST node's values should be unique")
            }
            
        }
        
        // check double red
    }
}
