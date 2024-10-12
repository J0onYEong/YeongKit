//
//  RBTree.swift
//  SwiftStructures
//
//  Created by choijunios on 10/10/24.
//

import Foundation

/// A Red-Black Tree implementation.
/// - Note: This type is **not thread-safe** for append and remove operations.
/// - All values in the tree must be unique. Attempting to insert a duplicate value will result in an error.
public class RBTree<Element> where Element: Comparable {
    
    typealias Node = RBTreeNode<Element>
    
    private(set) var rootNode: Node?
    
    public init(value: Element? = nil) {
        
        if let value {
            createRoot(value)
        }
    }
    
    /// height is starting from 1
    var height: Int {
        
        guard let rootNode else { return 0 }
        
        var currentNodes = [rootNode]
        var currentHeight = 0
        
        while !currentNodes.isEmpty {
            
            currentHeight += 1
            
            var newLayer: [Node] = []
            
            currentNodes.forEach { node in
                if !node.leftChild!.isEmptyNode {
                    newLayer.append(node.leftChild!)
                }
                if !node.rightChild!.isEmptyNode {
                    newLayer.append(node.rightChild!)
                }
            }
            
            currentNodes = newLayer
        }
        
        return currentHeight
    }
    
    private func createRoot(_ value: Element) {
        // Root node is always black
        self.rootNode = .init(value: value, color: .black)
    }
}

// MARK: Appending element
public extension RBTree {
    
    /// Append elements to tree
    func append(_ values: [Element]) throws {
        for value in values {
            try append(value)
        }
    }
    
    
    /// Append element to tree
    func append(_ value: Element) throws {
        
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
}



// MARK: Removing elements
public extension RBTree {
    
    func remove(_ value: Element) throws {
        
        guard let node = findNode(value) else {
            throw RBTreeError.cantFindElementInTree
        }
        
        remove(node)
    }
    
    private func remove(_ node: Node) {
        
        switch node.childrenState! {
        case .noChildren:
            whenNoChild(node)
        case .leftOnly:
            whenLeftOnly(node)
        case .rightOnly:
            whenRightOnly(node)
        case .twins:
            whenTwins(node)
        }
    }
    
    private func whenNoChild(_ node: Node) {
        // remove only this node
        node.parent?.removeChild(node)
    }
    
    private func whenLeftOnly(_ node: Node) {
        // find the most biggest node in left subtree of this node
        let biggestNodeInLeft = node.leftChild!.findTheBiggestNodeInSubtree()
        
        node.changeValue(biggestNodeInLeft.value!)
        
        // removing recursively
        remove(biggestNodeInLeft)
    }
    
    private func whenRightOnly(_ node: Node) {
        // find the most Smallest node in right subtree of this node
        var smallestNode: Node = node.rightChild!.findTheSmallestNodeInSubtree()
        
        node.changeValue(smallestNode.value!)
        
        // removing recursively
        remove(smallestNode)
    }
    
    private func whenTwins(_ node: Node) {
        
    }
    
    private func findNode(_ value: Element) -> Node? {
        
        guard let rootNode else { return nil }
        
        var currentNode: Node = rootNode
        
        while(currentNode.value != value) {
            
            if currentNode.value! > value {
                
                if currentNode.leftChild!.isEmptyNode {
                    return nil
                }
                currentNode = currentNode.leftChild!
            } else if currentNode.value! < value {
                
                if currentNode.rightChild!.isEmptyNode {
                    return nil
                }
                currentNode = currentNode.rightChild!
            }
        }
        
        return currentNode
    }
}



// MARK: Resolving dobule red
private extension RBTree {
    
    func resolveDoubleRed(_ newNode: Node) {
        
        // check double red
        let parentNode = newNode.parent!
        
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
    
    /// restructuring
    /// 1. sort newNode, parentNode, grandNode
    /// 2. make middle node to parent and the others its children.
    /// 3. make middle node to black and the others to red
    func restructuring(newNode: Node, parentNode: Node, grandNode: Node, uncleNode: Node) {
        
        // great grand node
        let greatGrandNode: Node? = grandNode === rootNode ? nil : grandNode.parent
        
        // break all relationship
        if let greatGrandNode {
            greatGrandNode.removeChild(grandNode)
        }
        grandNode.removeChild(parentNode)
        parentNode.removeChild(newNode)
    
        var sortedList = [newNode, parentNode, grandNode].sorted()
        let middleNode = sortedList.remove(at: 1)
        
        // set middle node to black
        middleNode.color = .black
        
        sortedList.forEach {
            $0.color = .red
            middleNode.setToChild($0)
        }
        
        if let greatGrandNode {
            greatGrandNode.setToChild(middleNode)
        } else {
            // middle node becomes root
            middleNode.parent = nil
            rootNode = middleNode
        }
    }
    
    
    /// recoloring
    /// 1. make parent and uncle to black
    /// 2. make grandNode to red
    /// 3. if grandNode is root, make it black
    func recoloring(newNode: Node, parentNode: Node, grandNode: Node, uncleNode: Node) {
        
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



// MARK: for test
extension RBTree where Element == Int {
    
    
    func printTree() {
        
        var printLayer: [Int: [RBTreeNode<Int>]] = [0: [rootNode!]]
        
        var currentLayerIndex = 0
        
        while(!printLayer[currentLayerIndex]!.isEmpty) {
            
            printLayer[currentLayerIndex+1] = []
            
            printLayer[currentLayerIndex]!.forEach { node in
                if !node.leftChild!.isEmptyNode {
                    printLayer[currentLayerIndex+1]!.append(node.leftChild!)
                }
                
                if !node.rightChild!.isEmptyNode {
                    printLayer[currentLayerIndex+1]!.append(node.rightChild!)
                }
            }
            
            currentLayerIndex += 1
        }
    
        
        for key in 0..<currentLayerIndex {
            
            for node in printLayer[key]! {
                
                let colorMark = node.color == .red ? "🟥" : "⬛️"
                print("\(colorMark)p:\(node.parent?.value ?? -1)v:\(node.value!)", terminator: " ")
            }
            print("\n", terminator: "")
        }
    }
}
