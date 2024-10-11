# Swift structures by junios



# Milestone

- [x] Red-black tree
- [ ] Thread-safe dictionary
    - [x] NSLock
    - [ ] Actor
- [ ] HashMap(powerd by RBTree)


## Red-black tree

This is a custom implementation of a Red-Black Tree in Swift. Red-Black Trees are self-balancing binary search trees, ensuring that the tree remains balanced during insertions and deletions. This tree is particularly useful for keeping operations like search, insert, and delete efficient, with a time complexity of O(log n).

### Features

- Self-Balancing: Ensures that the tree remains balanced after each insertion by using coloring and rotation.
- Unique Elements: The tree only supports unique elements. Inserting a duplicate element will throw an error.
- Non-Thread-Safe: The current implementation does not support thread-safe operations for appending and removing elements.

### Table of Contents

1. Usage
    - Creating the Tree
    - Appending Elements
    - Tree Height
    - Printing the Tree
2.	Internal Operations
    - Recoloring
    - Restructuring
    - Example
    - License


## Usage

Creating the Tree

To initialize a Red-Black Tree, use the RBTree class.

```swift
let tree = RBTree<Int>()
```

You can also initialize the tree with a root element:

```swift
let tree = RBTree<Int>(value: 10)
```

Appending Elements

You can append elements to the tree using the append function. You can append a single element or a list of elements.

``` swift
try tree.append(5)  // Appends a single element
try tree.append([20, 15, 25])  // Appends multiple elements

```

### Tree Height

You can get the current height of the tree by accessing the height property.

```swift
print("Tree height: \(tree.height)")
```

### Internal Operations

#### Recoloring

Recoloring is used when both the parent and uncle of a newly inserted node are red. It recolors the parent and uncle to black and the grandparent to red.

- If the grandparent is the root, it is recolored to black.

#### Restructuring

When recoloring isn’t enough, restructuring (or rotation) is used to maintain the Red-Black Tree properties. It sorts the new node, parent, and grandparent, makes the middle node the new parent, and assigns the others as its children. This operation ensures the balance of the tree.

#### Example

```swift
let tree = RBTree<Int>()

try tree.append(10)
try tree.append([5, 20, 15, 25])
```

## Thread-safe dictionary

### LockedDictionary

LockedDictionary is a custom thread-safe wrapper around Swift’s native Dictionary. It ensures safe, concurrent access to its elements by using a lock (NSLock). This class is particularly useful in multithreaded environments where concurrent reads and writes to a dictionary could lead to data races or inconsistencies.

#### Example

```swift
let dictionary = LockedDictionary<Int, String>()

// Add elements
dictionary[1] = "One"
dictionary[2] = "Two"

// Access elements
let value = dictionary[1]  // "One"

dictionary.remove(key: 1)
let value = dictionary[1]  // nil, since the element was removed

```

## License

This project is open-source and available under the MIT License.
