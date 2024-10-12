//
//  HashMap.swift
//  SwiftStructures
//
//  Created by choijunios on 10/13/24.
//

import Foundation

public class HashMap<Key, Value> where Key: Hashable {
    
    typealias Store = LockedDictionary<Key, Value>
    
    private let store: Store = .init()
    
    public subscript(key: Key) -> Value? {
        get {
            return store[key]
        }
        set(newValue) {
            store[key] = newValue
        }
    }
}
