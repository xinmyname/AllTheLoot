//
//  Loot.swift
//  AllTheLoot
//
//  Created by Andy Sherwood on 7/12/16.
//  Copyright © 2016 Andy Sherwood. All rights reserved.
//

import Foundation


class Loot:CustomStringConvertible {
    
    var _quantity:Int = 1
    let _descriptor:Descriptor

    init() {
        _descriptor = Descriptor(array: [Kind.oneAtRandom().rawValue])
    }
    
    init(descriptor:Descriptor) {
        _descriptor = descriptor
    }

    var kind:Kind {
        return Kind(rawValue: _descriptor[0])!
    }
    
    var description: String {
        let it = _descriptor.iterator
        
        do {
            let kind = try it.nextKind()

            switch kind {
            case .weapon: return try describeWeapon(iterator:it)
            case .armor: return try describeArmor(iterator:it)
            case .monsterPart: return try describeMonsterPart(iterator:it)
            case .tool: return try describeTool(iterator:it)
            case .scroll: return try describeScroll(iterator:it)
            case .wand: return try describeWand(iterator:it)
            case .potion: return try describePotion(iterator:it)
            case .amulet: return try describeAmulet(iterator:it)
            case .ring: return try describeRing(iterator:it)
            case .bracelet: return try describeBracelet(iterator:it)
            case .necklace: return try describeNecklace(iterator:it)
            case .staff: return try describeStaff(iterator:it)
            case .key: return try describeKey(iterator:it)
            case .ammunition: return try describeAmmunition(iterator:it)
            case .gemstone: return try describeGemstone(iterator:it)
            case .ore: return try describeOre(iterator:it)
            case .clothes: return try describeClothes(iterator:it)
            case .book: return try describeBook(iterator:it)
            case .silverware: return try describeSilverware(iterator:it)
            }
        }
        catch let error as NSError {
            return "(error: \(error.localizedDescription))"
        }
    }

    func describeWeapon(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeArmor(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeMonsterPart(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeTool(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeScroll(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeWand(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describePotion(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeAmulet(iterator:DescriptorIterator) throws -> String {
        let style:Int = try iterator.next()
        switch style {
            
        case 0:
            let metal = try iterator.nextItem(Loot.Metals)
            return "\(metal) ^Amulet"
            
        case 1:
            let metal = try iterator.nextOptionalItem(Loot.Metals)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return "\(metal) ^Amulet of \(characteristic)".fixSpace()
            
        case 2:
            let gem = try iterator.nextItem(Loot.Gems)
            return "\(gem) ^Amulet"
            
        case 3:
            let gem = try iterator.nextItem(Loot.Gems)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return "\(gem) ^Amulet of \(characteristic)"
            
        case 4:
            return "The Amulet of Yendor"
            
        default:
            return ""
        }
    }
    
    func describeRing(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeBracelet(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeNecklace(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeStaff(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeKey(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeAmmunition(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeGemstone(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeOre(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeClothes(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeBook(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func describeSilverware(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    
    private static let Metals = [
        "Iron",
        "Silver",
        "Gold",
        "Platinum",
        "Copper",
        "Steel",
        "Brass",
        "Nickel",
        "Tungsten",
        "Palladium",
        "Tin",
        "Bronze",
        "Unobtainium"
    ]
    
    private static let Gems = [
        "Ruby",
        "Diamond",
        "Quartz",
        "Emerald",
        "Jade",
        "Opal",
        "Onyx",
        "Pearl",
        "Sapphire",
        "Topaz",
        "Turquoise",
        "Cubit Zirconia"
    ]
    
    private static let Characteristics = [
        "Healing",
        "Pain",
        "Agony",
        "Hunger",
        "Strength",
        "Agility",
        "Stamina",
        "Intellect",
        "Teleportation",
        "Protection",
        "Invisibility",
        "Speed",
        "Slowness",
        "Heaviness",
        "Lightness",
        "Blundering",
        "Clumsiness",
        "Dexterity",
        "Sleepiness",
        "Hate",
        "Amore",
        "Vigor",
        "Itching",
        "Accuracy",
        "Cowardice",
        "Inebriation",
        "Sobriety",
        "Endurance",
        "Persuasion",
        "Polymorphism",
        "Blindness"
    ]
    
    enum Kind:Int,CustomStringConvertible {
        
        case weapon
        case armor
        case monsterPart
        case tool
        case scroll
        case wand
        case potion
        case amulet
        case ring
        case bracelet
        case necklace
        case staff
        case key
        case ammunition
        case gemstone
        case ore
        case clothes
        case book
        case silverware
        
        var description:String {
            switch self {
            case weapon: return "Weapon"
            case armor: return "Armor"
            case monsterPart: return "Monster Part"
            case tool: return "Tool"
            case scroll: return "Scroll"
            case wand: return "Wand"
            case potion: return "Potion"
            case amulet: return "Amulet"
            case ring: return "Ring"
            case bracelet: return "Bracelet"
            case necklace: return "Necklace"
            case staff: return "Staff"
            case key: return "Key"
            case ammunition: return "Ammunition"
            case gemstone: return "Gemstone"
            case ore: return "Ore"
            case clothes: return "Clothes"
            case book: return "Book"
            case silverware: return "Silverware"
            }
        }
        
        private static var _count:Int {
            get {
                var max:Int = 0
                while let _ = Kind(rawValue: max) {
                    max += 1
                }
                return max
            }
        }
        
        static func oneAtRandom() -> Kind {
            return Kind(rawValue: Int(arc4random_uniform(UInt32(_count))))!
        }
    }
}

