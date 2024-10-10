//
//  SwiftStructuresTests.swift
//  SwiftStructuresTests
//
//  Created by choijunios on 10/10/24.
//

import XCTest
@testable import SwiftStructures

class SwiftStructuresTests: XCTestCase {

    func testRBTreeMakeBalanceBST() throws {
        
        let rbTree = RBTree<Int>()
        let testElements = [56, 10, 3, 61, 49, 97, 9, 72, 40, 94, 67, 2, 98, 5, 71, 57, 15, 36, 87, 99]
        
        let expactedTreeHeight = 5
        
        testElements.forEach { element in
            
            do {
                try rbTree.append(element)
                rbTree.printTree()
                print("------------")
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
        
        rbTree.printTree()
        
        XCTAssertEqual(rbTree.height, expactedTreeHeight)
    }

}
