//
//  Descriptor.swift
//  AllTheLoot
//
//  Created by Andy Sherwood on 7/15/16.
//  Copyright © 2016 Andy Sherwood. All rights reserved.
//

import Foundation

struct Descriptor:CustomStringConvertible {
    
    private var _contents:[Int]
    
    var count:Int {
        get { return _contents.count }
    }
    
    init() {
        _contents = []
    }

    init(string:String) {
        _contents = string.components(separatedBy: "-").map { Int($0)! }
    }
    
    init(array:[Int]) {
        _contents = array
    }
    
    subscript(index:Int) -> Int {
        return _contents[index]
    }
    
    var description: String {
        return _contents.map{String($0)}.joined(separator:"-")
    }
    
    var iterator: DescriptorIterator {
        return DescriptorIterator(_contents.makeIterator())
    }
    
    mutating func append(value:Int) {
        _contents.append(value)
    }

    mutating func append(index:Int?) {
        if let index = index {
            _contents.append(index+1)
        } else {
            _contents.append(0)
        }
    }
}

class DescriptorIterator {
    
    enum NoMoreItems:ErrorProtocol { case error }
    enum InvalidLootKind:ErrorProtocol { case error }
    
    private var _it:IndexingIterator<[Int]>
    
    init(_ it:IndexingIterator<[Int]>) {
        _it = it
    }
    
    func next() throws -> Int {
        
        guard let value = _it.next() else {
            throw NoMoreItems.error
        }
        
        return value
    }
    
    func nextIndex() throws -> Int {
        
        guard let value = _it.next() else {
            throw NoMoreItems.error
        }
        
        return value-1
    }

    func nextKind() throws -> Loot.Kind {
        
        guard let value = _it.next() else {
            throw NoMoreItems.error
        }
        
        guard let kind = Loot.Kind(rawValue: value) else {
            throw InvalidLootKind.error
        }
        
        return kind
    }
    
    func nextItem(_ items:[String]) throws -> String {
        
        guard let value = _it.next() else {
            throw NoMoreItems.error
        }
        
        return items[value-1]
    }

    func nextOptionalItem(_ items:[String]) throws -> String {
        
        guard let value = _it.next() else {
            throw NoMoreItems.error
        }
        
        if value == 0 {
            return "?"
        }
        
        return items[value-1]
    }
}
