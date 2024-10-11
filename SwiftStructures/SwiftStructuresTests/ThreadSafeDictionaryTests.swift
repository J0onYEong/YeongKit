//
//  ThreadSafeDictionary.swift
//  SwiftStructuresTests
//
//  Created by choijunios on 10/11/24.
//

import XCTest
@testable import SwiftStructures

final class ThreadSafeDictionary: XCTestCase {

    func testThreadSaftyForLockedDictionary() {
        let dictionary = LockedDictionary<Int, String>()
        let expectation = XCTestExpectation(description: "Multiple threads access LockedDictionary safely")
        expectation.expectedFulfillmentCount = 10 // 10개의 스레드가 완료되기를 기다림
        
        DispatchQueue.concurrentPerform(iterations: 100) { index in
            DispatchQueue.global().async {
                let testValue = "Value \(index)"
                dictionary[index] = testValue // 쓰기 작업
                
                let value = dictionary[index] // 읽기 작업
                XCTAssertEqual(value, testValue, "Value mismatch in thread \(index)")
                
                dictionary.remove(key: index) // 삭제 작업
                
                expectation.fulfill() // 스레드 작업 완료
            }
        }
        
        wait(for: [expectation], timeout: 5.0) // 5초 내에 모든 스레드가 완료되기를 기대
    }
}
