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
    public func append(_ value: Element) throws {
        
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
                throw RBTreeError.duplicatedElement
            }
        }
        
        // check double red
        let parent = newNode.parent!
        let leftChild = newNode.leftChild
        let rightChild = newNode.rightChild
        
        if parent.color == .red && (leftChild.color == .red || rightChild.color == .red) {
            // double red condition
            
            // parent isn't root so it must has parent
            let grand = parent.parent!
            let uncle = grand.getSibilingNode(parent)
            
            if uncle.color == .red {
                
                // start recoloring
                
            } else {
                
                // start reconstructing
            }
        }
    }
}
