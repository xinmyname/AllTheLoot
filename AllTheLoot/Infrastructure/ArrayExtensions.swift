//
//  ArrayExtensions.swift
//  AllTheLoot
//
//  Created by Andy Sherwood on 7/12/16.
//  Copyright © 2016 Andy Sherwood. All rights reserved.
//

import Foundation

enum RandomNilStrategy {
    case always
    case never
    case fiftyFifty
    case equalChance
    case probability(value:Float)
}

extension Array {
    func oneAtRandom(strategy:RandomNilStrategy = .never) -> Element? {
        
        switch strategy {
        case .always:
            return nil
        case .never:
            return self[Int(arc4random_uniform(UInt32(self.count)))]
        case .fiftyFifty:
            if Int(arc4random_uniform(10)) >= 5 {
                return self[Int(arc4random_uniform(UInt32(self.count)))]
            }
            return nil
        case .equalChance:
            let idx = Int(arc4random_uniform(UInt32(self.count+1)))
            if (idx == self.count) {
                return nil
            }
            return self[idx]
        case .probability(let value):
            if Int(arc4random_uniform(100)) > Int(value * 100.0) {
                return self[Int(arc4random_uniform(UInt32(self.count)))]
            }
            return nil
        }
    }
}
