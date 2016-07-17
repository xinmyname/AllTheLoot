//
//  StringExtensions.swift
//  AllTheLoot
//
//  Created by Andy Sherwood on 7/16/16.
//  Copyright © 2016 Andy Sherwood. All rights reserved.
//

import Foundation

extension String {
    func fixSpace() -> String {
        var found = false
        var text = self
        
        while !found {
            
            if let r:Range<String.Index> = text.range(of: "?") {
                
                text.remove(at: r.lowerBound)
                text.remove(at: r.lowerBound)
                
            } else {
                found = true
            }
        }
        
        return text
    }
}
