//
//  HashMapTests.swift
//  SwiftStructuresTests
//
//  Created by choijunios on 10/13/24.
//

import XCTest
@testable import SwiftStructures

class HashMapTests: XCTestCase {
    
    func testInsertionAndRetrieval() {
        // Given
        let hashMap = HashMap<Int, String>()
        
        // When
        hashMap[1] = "One"
        hashMap[2] = "Two"
        hashMap[3] = "Three"
        
        // Then
        XCTAssertEqual(hashMap[1], "One", "Value for key 1 should be 'One'")
        XCTAssertEqual(hashMap[2], "Two", "Value for key 2 should be 'Two'")
        XCTAssertEqual(hashMap[3], "Three", "Value for key 3 should be 'Three'")
    }
    
    func testRemoveKey() {
        // Given
        let hashMap = HashMap<Int, String>()
        
        // Insert some values
        hashMap[1] = "One"
        hashMap[2] = "Two"
        hashMap[3] = "Three"
        
        // When
        hashMap.remove(2)  // Remove the key 2
        
        // Then
        XCTAssertNil(hashMap[2], "Value for key 2 should be nil after removal")
        XCTAssertEqual(hashMap[1], "One", "Value for key 1 should still be 'One'")
        XCTAssertEqual(hashMap[3], "Three", "Value for key 3 should still be 'Three'")
    }
    
    func testInsertionOfExistingKey() {
        // Given
        let hashMap = HashMap<Int, String>()
        
        // Insert a value
        hashMap[1] = "One"
        
        // When
        hashMap[1] = "Updated One"  // Update the value for key 1
        
        // Then
        XCTAssertEqual(hashMap[1], "Updated One", "Value for key 1 should be updated to 'Updated One'")
    }
    
    func testASCAndDESCList() {
        
        let hashMap = HashMap<Int, String>()
        let testCase = (1...10).shuffled()

        testCase.forEach { (element) in
            hashMap[element] = String(element)
        }
        
        XCTAssertEqual(
            hashMap.ascendingValues(5),
            testCase.sorted(by: <)[0..<5].map(String.init)
        )
    }
}
