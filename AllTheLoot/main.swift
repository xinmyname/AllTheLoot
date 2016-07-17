//
//  main.swift
//  AllTheLoot
//
//  Created by Andy Sherwood on 7/12/16.
//  Copyright © 2016 Andy Sherwood. All rights reserved.
//

import Foundation


var d = Descriptor()

d.append(value: Loot.Kind.amulet.rawValue)
d.append(value: 1)
d.append(value: 5)
d.append(value: 3)

print(d)

let loot = Loot(descriptor: d)

print(loot)

