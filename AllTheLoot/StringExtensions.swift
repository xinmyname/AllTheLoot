//
//  StringExtensions.swift
//  AllTheLoot
//
//  Created by Andy Sherwood on 7/16/16.
//  Copyright © 2016 Andy Sherwood. All rights reserved.
//

import Foundation

extension String {
    func starts(withAny prefixes:[String]) -> Bool {
        
        for prefix in prefixes {
            
            if let range = self.range(of: prefix) {
                if range.lowerBound == self.startIndex {
                    return true
                }
            }
        }
        
        return false
    }
}
