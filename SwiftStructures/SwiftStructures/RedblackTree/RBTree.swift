//
//  RBTree.swift
//  SwiftStructures
//
//  Created by choijunios on 10/10/24.
//

import Foundation

public class RBTree<Element> where Element: Comparable {
    
    typealias Node = RBTreeNode<Element>
    
    private(set) var rootNode: Node?
    
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
            
            if currentParentNode.isEmptyNode {
                // CurrentNode is empty leaf node
                currentParentNode.parent?.setToChild(newNode)
                break
            }
            
            if currentParentNode > newNode {
                // go left
                currentParentNode = currentParentNode.leftChild
            } else if currentParentNode < newNode {
                // go right
                currentParentNode = currentParentNode.rightChild
            } else {
                throw RBTreeError.duplicatedElement
            }
        }
        
        // start checking double red
        resolveDoubleRed(newNode)
    }
    
    private func resolveDoubleRed(_ newNode: Node) {
        
        // check double red
        let parentNode = newNode.parent!
        let leftChild = newNode.leftChild
        let rightChild = newNode.rightChild
        
        if parentNode.color == .red {
            // double red condition
            
            // parent isn't root so it must has parent
            let grandNode = parentNode.parent!
            let uncleNode = grandNode.getSibilingNode(parentNode)
            
            if uncleNode.color == .red {
                
                // start recoloring
                recoloring(
                    newNode: newNode,
                    parentNode: parentNode,
                    grandNode: grandNode,
                    uncleNode: uncleNode
                )
                
            } else {
                
                // start reconstructing
                restructuring(
                    newNode: newNode,
                    parentNode: parentNode,
                    grandNode: grandNode,
                    uncleNode: uncleNode
                )
            }
        }
    }
    
    private func restructuring(newNode: Node, parentNode: Node, grandNode: Node, uncleNode: Node) {
        
        var sortedList = [newNode, parentNode, grandNode].sorted()
        let middleNode = sortedList.remove(at: 1)
        sortedList.forEach {
            $0.color = .red
            middleNode.setToChild($0)
        }
    }
    
    private func recoloring(newNode: Node, parentNode: Node, grandNode: Node, uncleNode: Node) {
        
        // make parent and uncle to black
        parentNode.color = .black
        uncleNode.color = .black
        
        // make grand to black whether it isn't root
        grandNode.color = .red
        
        if grandNode === rootNode {
            grandNode.color = .black
            return
        } else {
            
            // check whether grand node makes double red again
            resolveDoubleRed(grandNode)
        }
    }
}
