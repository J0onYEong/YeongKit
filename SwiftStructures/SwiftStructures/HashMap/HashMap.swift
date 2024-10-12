//
//  HashMap.swift
//  SwiftStructures
//
//  Created by choijunios on 10/13/24.
//

import Foundation

/// Thread safe hash map
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


// MARK: sorted value list
public extension HashMap {
    
    func ascendingValues(_ count: Int) -> [Value] {
        defer {
            lock.unlock()
        }
        lock.lock()
        
        let keys = keyStore.sortedList(type: .ASC)
        let maxCount = count > dictionary.count ? dictionary.count : count
        let slicedKeys = keys[0..<maxCount]
        
        return slicedKeys.compactMap { key in
            dictionary[key]
        }
    }
    
    func descendingValues(_ count: Int) -> [Value] {
        defer {
            lock.unlock()
        }
        lock.lock()
        
        let keys = keyStore.sortedList(type: .DESC)
        let maxCount = count > dictionary.count ? dictionary.count : count
        let slicedKeys = keys[0..<maxCount]
        
        return slicedKeys.compactMap { key in
            dictionary[key]
        }
    }
}
