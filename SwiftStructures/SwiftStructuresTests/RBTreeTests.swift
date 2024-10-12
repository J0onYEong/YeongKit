//
//  SwiftStructuresTests.swift
//  SwiftStructuresTests
//
//  Created by choijunios on 10/10/24.
//

import XCTest
@testable import SwiftStructures

class RBTreeTests: XCTestCase {

    func testRBTreeMakeBalanceBST20() throws {
        
        let testCases = [
            [71, 3, 31, 10, 24, 54, 32, 22, 96, 68, 62, 11, 97, 67, 61, 52, 43, 49, 59, 80],
            [40, 70, 45, 53, 2, 50, 83, 7, 47, 42, 4, 65, 46, 38, 95, 18, 79, 6, 1, 27],
            [44, 30, 82, 76, 87, 15, 41, 26, 51, 64, 20, 39, 19, 90, 16, 94, 72, 99, 84, 78],
        ]
        
        for testCase in testCases {
            let expactedTreeHeightRange = 5...6
            
            let rbTree = RBTree<Int>()
            
            testCase.forEach { element in
                
                do {
                    try rbTree.append(element)
                } catch {
                    XCTFail(error.localizedDescription)
                }
            }
            
            rbTree.printTree()
            
            XCTAssertTrue((expactedTreeHeightRange).contains(rbTree.height))
            print("------------")
        }
    }
    
    func testRBTreeMakeBalanceBST40() throws {
        
        let testCases = [
            [48, 18, 47, 62, 66, 15, 28, 33, 94, 49, 3, 76, 37, 38, 40, 68, 78, 11, 92, 36,
            69, 4, 95, 53, 23, 12, 81, 88, 44, 32, 46, 91, 14, 74, 80, 86, 22, 25, 39, 1]
        ]
    
        for testCase in testCases {
            let expactedTreeHeightRange = 6...7
            
            let rbTree = RBTree<Int>()
            
            testCase.forEach { element in
                
                do {
                    try rbTree.append(element)
                } catch {
                    XCTFail(error.localizedDescription)
                }
                
                rbTree.printTree()
            }
            XCTAssertTrue((expactedTreeHeightRange).contains(rbTree.height))
            print("------------")
        }
    }
    
    func testDuplicateElement() {
        
        let rbTree = RBTree<Int>()
        let testElements = [1, 2 ,3, 4, 5, 5]
        var currentElement = 0
        
        do {
            for element in testElements {
                currentElement = element
                try rbTree.append(element)
            }
            XCTFail()
        } catch {
            XCTAssertEqual(currentElement, 5)
        }
    }
    
    func testRemoveElementAndKeepBalanceTree() {
        
        let rbTree = RBTree<Int>()
        let testElements: Array = .init(1...15)
        
        
        for element in testElements {
            try! rbTree.append(element)
        }
        
        rbTree.printTree()
        
        let heightBeforeRemove = rbTree.height
        
        // remove 8 elements
        for element in 1..<8 {
            do {
                
                let node = rbTree.findNode(element)
                print("will remove: \(element), chilrenState: \(node!.childrenState!)")
                
                try rbTree.remove(element)
                
                rbTree.printTree()
            
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
        
        print("------------")
        
        rbTree.printTree()
        
        // height at lease discounted 1
        XCTAssertLessThanOrEqual(rbTree.height, heightBeforeRemove)
    }
}
