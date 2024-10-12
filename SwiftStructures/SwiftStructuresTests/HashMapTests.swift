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
        
        print(hashMap.ascendingValues(100))
        print(hashMap.descendingValues(100))
        XCTAssertEqual(
            hashMap.ascendingValues(100),
            testCase.sorted(by: <).map(String.init)
        )
        
        XCTAssertEqual(
            hashMap.descendingValues(100),
            testCase.sorted(by: >).map(String.init)
        )
    }
    
    func testMultithreadedInsertionAndRetrieval() async {
        // Given
        let hashMap = HashMap<Int, String>()
        let expectation = XCTestExpectation(description: "Multiple threads insert and retrieve values in HashMap")
        expectation.expectedFulfillmentCount = 100  // Expect 100 threads to finish
        
        // When
        await withTaskGroup(of: Void.self) { group in
            for index in 0..<100 {
                group.addTask {
                    let testValue = "Value \(index)"
                    hashMap[index] = testValue  // Insert value
                    let value = hashMap[index]  // Retrieve value
                    XCTAssertEqual(value, testValue, "Value mismatch in thread \(index)")
                    expectation.fulfill()  // Thread finished
                }
            }
        }
        
        // Then
        await fulfillment(of: [expectation], timeout: 10.0)
    }
    
    func testMultithreadedRemoval() async {
        // Given
        let hashMap = HashMap<Int, String>()
        let expectation = XCTestExpectation(description: "Multiple threads remove values in HashMap")
        expectation.expectedFulfillmentCount = 100  // Expect 100 threads to finish
        
        // Insert initial values
        for index in 0..<100 {
            hashMap[index] = "Value \(index)"
        }
        
        // When
        await withTaskGroup(of: Void.self) { group in
            for index in 0..<100 {
                group.addTask {
                    hashMap.remove(index)  // Remove value
                    let value = hashMap[index]  // Attempt to retrieve the removed value
                    XCTAssertNil(value, "Value for key \(index) should be nil after removal")
                    expectation.fulfill()  // Thread finished
                }
            }
        }
        
        // Then
        await fulfillment(of: [expectation], timeout: 10.0)
    }
}
