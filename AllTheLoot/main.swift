//
//  main.swift
//  AllTheLoot
//
//  Created by Andy Sherwood on 7/12/16.
//  Copyright © 2016 Andy Sherwood. All rights reserved.
//

import Foundation

var d = Descriptor()

d.append(value: Loot.Kind.armor.rawValue)
d.append(value: 0)
d.append(value: 5)
d.append(value: 1)
d.append(value: 3)
d.append(value: 4)

//print(d)
//let l = Loot(descriptor: d, quantity: 1)
//print(l)

for i in 0...10 {
    let loot = Loot()
    loot.quantity = Int(arc4random_uniform(3)+1)
    print(loot)
}

