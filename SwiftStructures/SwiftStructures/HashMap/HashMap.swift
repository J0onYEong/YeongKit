//
//  HashMap.swift
//  SwiftStructures
//
//  Created by choijunios on 10/13/24.
//

import Foundation

public class HashMap<Key, Value> where Key: Hashable & Comparable {
    
    typealias KeyStore = RBTree<Key>
    
    private var dictionary: [Key: Value] = .init()
    private let keyStore: KeyStore = .init()
    
    private let lock: NSLock = .init()
    
    public subscript(key: Key) -> Value? {
        get {
            defer {
                lock.unlock()
            }
            lock.lock()
            
            return dictionary[key]
        }
        set(newValue) {
            defer {
                lock.unlock()
            }
            lock.lock()
            
            if dictionary[key] == nil {
                // key isn't exists in dictionary
                try! keyStore.append(key)
            }
            
            dictionary[key] = newValue
        }
    }
    
    public func remove(_ key: Key) {
        defer {
            lock.unlock()
        }
        lock.lock()
        
        do {
            try keyStore.remove(key)
        } catch {
            print("\(HashMap.self): " + error.localizedDescription)
        }
        
        dictionary.removeValue(forKey: key)
    }
}
