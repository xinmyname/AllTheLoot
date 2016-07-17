//
//  Loot.swift
//  AllTheLoot
//
//  Created by Andy Sherwood on 7/12/16.
//  Copyright © 2016 Andy Sherwood. All rights reserved.
//

import Foundation


public class Loot:CustomStringConvertible {
    
    private var _descriptor:Descriptor

    public var quantity:Int = 1

    init() {
        let kind = Kind.weapon
        _descriptor = Descriptor(array: [kind.rawValue])
        
        switch kind {
        case .weapon: makeWeapon()
        case .armor: makeArmor()
        case .monsterPart: makeMonsterPart()
        case .tool: makeTool()
        case .scroll: makeScroll()
        case .wand: makeWand()
        case .potion: makePotion()
        case .amulet: makeAmulet()
        case .ring: makeRing()
        case .bracelet: makeBracelet()
        case .necklace: makeNecklace()
        case .staff: makeStaff()
        case .key: makeKey()
        case .ammunition: makeAmmunition()
        case .gemstone: makeGemstone()
        case .ore: makeOre()
        case .clothes: makeClothes()
        case .book: makeBook()
        case .utensil: makeUtensil()
        }
    }
    
    init(descriptor:Descriptor) {
        _descriptor = descriptor
    }

    init(descriptor:Descriptor, quantity:Int) {
        _descriptor = descriptor
        
        self.quantity = quantity
    }
    
    public var kind:Kind {
        return Kind(rawValue: _descriptor[0])!
    }
    
    public var description: String {
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
            case .utensil: return try describeUtensil(iterator:it)
            }
        }
        catch let error as NSError {
            return "(error: \(error.localizedDescription))"
        }
    }

    func makeWeapon() {
        
        let style = Int(arc4random_uniform(2))
        
        _descriptor.append(value: style)

        _descriptor.append(index: Loot.Weights.oneIndexAtRandom(strategy: .equalChance))
        
        switch style {
        
        case 0: _descriptor.append(index: Loot.Races.oneIndexAtRandom(strategy: .equalChance))
        
        case 1: _descriptor.append(index: Loot.Materials.oneIndexAtRandom(strategy: .equalChance))
        
        default:break
        
        }
        
        _descriptor.append(index: Loot.Weapons.oneIndexAtRandom())
    }
    
    func describeWeapon(iterator:DescriptorIterator) throws -> String {
        
        let style:Int = try iterator.next()
        
        switch style {
        
        case 0:
            let weight = try iterator.nextOptionalItem(Loot.Weights)
            let race = try iterator.nextOptionalItem(Loot.Races)
            let weapon = try iterator.nextItem(Loot.Weapons)
            return postProcess("\(weight) \(race) \(weapon)")
            
        case 1:
            let weight = try iterator.nextOptionalItem(Loot.Weights)
            let material = try iterator.nextOptionalItem(Loot.Materials)
            let weapon = try iterator.nextItem(Loot.Weapons)
            return postProcess("\(weight) \(material) \(weapon)")
        
        default:
            return ""
        }
    
    }
    
    func makeArmor() {
        
    }

    func describeArmor(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeMonsterPart() {
        
    }
    
    func describeMonsterPart(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeTool() {
        
    }
    
    func describeTool(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeScroll() {
        
    }
    
    func describeScroll(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeWand() {
        
    }
    
    func describeWand(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makePotion() {
        
    }
    
    func describePotion(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeAmulet() {
        
        let randomStyle = arc4random_uniform(4001)
        let style = (randomStyle != 4000)
            ? Int(randomStyle / 1000)
            : 4
        
        _descriptor.append(value: style)
        
        switch style {

        case 0:
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom())
        
        case 1:
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom(strategy: .equalChance))
            _descriptor.append(index: Loot.Characteristics.oneIndexAtRandom())
        
        case 2:
            _descriptor.append(index: Loot.Gems.oneIndexAtRandom())
        
        case 3:
            _descriptor.append(index: Loot.Gems.oneIndexAtRandom())
            _descriptor.append(index: Loot.Characteristics.oneIndexAtRandom())
        default:
            break
        }
    }
    
    func describeAmulet(iterator:DescriptorIterator) throws -> String {
        
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let metal = try iterator.nextItem(Loot.Metals)
            return postProcess("\(metal) ^Amulet")
            
        case 1:
            let metal = try iterator.nextOptionalItem(Loot.Metals)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return postProcess("\(metal) ^Amulet of \(characteristic)")
            
        case 2:
            let gem = try iterator.nextItem(Loot.Gems)
            return postProcess("\(gem) ^Amulet")
            
        case 3:
            let gem = try iterator.nextItem(Loot.Gems)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return postProcess("\(gem) ^Amulet of \(characteristic)")
            
        case 4:
            return "The Amulet of Yendor"
            
        default:
            return ""
            
        }
    }
    
    func makeRing() {
        
    }
    
    func describeRing(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeBracelet() {
        
    }
    
    func describeBracelet(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeNecklace() {
        
    }
    
    func describeNecklace(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeStaff() {
        
    }
    
    func describeStaff(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeKey() {
        
    }
    
    func describeKey(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeAmmunition() {
        
    }
    
    func describeAmmunition(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeGemstone() {
        
    }
    
    func describeGemstone(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeOre() {
        
    }
    
    func describeOre(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeClothes() {
        
    }
    
    func describeClothes(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeBook() {
        
    }
    
    func describeBook(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    func makeUtensil() {
        
    }
    
    func describeUtensil(iterator:DescriptorIterator) throws -> String {
        return ""
    }
    
    private func postProcess(_ text:String) -> String {
        
        var found = false
        var text = text
        
        while !found {
            
            if let optionalRange:Range<String.Index> = text.range(of: "?") {
                
                text.remove(at: optionalRange.lowerBound)
                text.remove(at: optionalRange.lowerBound)
                
            } else {
                found = true
            }
        }
        
        if let pluralRange = text.range(of: "^") {
            
            let startIndex = pluralRange.lowerBound
            
            if self.quantity == 1 {
                text.remove(at: startIndex)
                return text
            }
            
            var singular = text.substring(from: pluralRange.upperBound)
            
            if let spaceRange = singular.range(of: " ") {
                singular = singular.substring(to: spaceRange.lowerBound)
            }
            
            let plural = singular.pluralize()
            
            let distance = singular.distance(from: singular.startIndex, to: singular.endIndex)
            let endIndex = text.index(startIndex, offsetBy: distance+1)
            
            text = text.replacingCharacters(in: startIndex..<endIndex, with: plural)
            
            var quantityText = ""
            
            switch self.quantity {
            case 2: quantityText = "Two"
            case 3: quantityText = "Three"
            case 4: quantityText = "Four"
            case 5: quantityText = "Five"
            case 6: quantityText = "Six"
            case 7: quantityText = "Seven"
            case 8: quantityText = "Eight"
            case 9: quantityText = "Nine"
            default:
                quantityText = String(self.quantity)
            }
            
            text = "\(quantityText) \(text)"
        }
        
        return text
    }
    
    private static let Weapons = [
        "^Dagger",
        "^Knife",
        "^Axe",
        "Short ^Sword",
        "^Broadsword",
        "Long ^Sword",
        "^Katana",
        "^Saber",
        "^Club",
        "^Mace",
        "Morning ^Star",
        "^Flail",
        "^Quarterstaff",
        "^Polearm",
        "^Spear",
        "^Bow",
        "^Crossbow"
    ]
    
    private static let Armors = [
        "Armor",
        "Gauntlets",
        "^Helm",
        "Boots"
    ]
    
    private static let MonsterParts = [
        "^Hide",
        "^Fur",
        "^Tusk",
        "^Horn",
        "^Tooth",
        "^Bone"
    ]
    
    private static let Tools = [
        "^Saw",
        "^Axe",
        "Scissors",
        "^Hammer",
        "^Wrench",
        "Pliers"
    ]
    
    private static let Clothes = [
        "^Shirt",
        "Trousers",
        "^Shorts",
        "Capris",
        "^Skirt",
        "^Robe",
        "^Hood",
        "^Glove",
        "^Dress",
        "^Jacket",
        "^Vest",
        "Pajamas",
        "^Scarf",
        "^Coat",
        "^Cap",
        "^Cape",
        "^Mask",
        "^Headband"
    ]
    
    private static let Utensils = [
        "^Fork",
        "^Spoon",
        "^Knife"
    ]
    
    private static let Races = [
        "Elven",
        "Orcish",
        "Dwarven",
        "Gnomish",
        "Demonic",
        "Undead"
    ]

    private static let Aspects = [
        "Shimmering",
        "Sparkling",
        "Glittering",
        "Incandescent",
        "Glowing",
        "Dirty",
        "Dingy",
        "Shabby",
        "Faded",
        "Bright",
        "Flawless",
        "Translucent",
        "Cloudy"
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
    
    private static let Lengths = [
        "Short",
        "Medium",
        "Long"
    ]
    
    private static let Sizes = [
        "Very Small",
        "Small",
        "Medium",
        "Large",
        "Extra Large",
        "Extremely Large"
    ]
    
    private static let Weights = [
        "Weightless",
        "Very Light",
        "Light",
        "Heavy",
        "Very Heavy",
        "Extremely Heavy"
    ]
    
    public static let Colors = [
        "White",
        "Azure",
        "Blue",
        "Aquamarine",
        "Crimson",
        "Red",
        "Brown",
        "Golden",
        "Green",
        "Gray",
        "Lavendar",
        "Pink",
        "Indigo",
        "Green",
        "Cream",
        "Eggshell",
        "Beige",
        "Ecru",
        "Turquoise",
        "Tan",
        "Teal",
        "Yellow",
        "Purple",
        "Magenta",
        "Cornflower Blue"
    ]
    
    private static let MetalElements = [
        "Aluminum",
        "Titanium",
        "Vanadium",
        "Chromium",
        "Manganese",
        "Iron",
        "Cobalt",
        "Nickel",
        "Copper",
        "Zinc",
        "Gallium",
        "Yttrium",
        "Zirconium",
        "Niobium",
        "Molybdenum",
        "Ruthenium",
        "Rhodium",
        "Palladium",
        "Silver",
        "Cadmium",
        "Indium",
        "Tin",
        "Hafnium",
        "Tantalum",
        "Tungsten",
        "Rhenium",
        "Osmium",
        "Iridium",
        "Platinum",
        "Gold",
        "Thallium",
        "Lead",
        "Bismuth",
        "Polonium",
        "Thorium",
        "Uranium",
        "Plutonium"
    ]

    private static let Metals = [
        "Aluminum",
        "Titanium",
        "Iron",
        "Cast Iron",
        "Silver",
        "Gold",
        "Rose Gold",
        "White Gold",
        "Platinum",
        "Copper",
        "Steel",
        "Brass",
        "Nickel",
        "Zinc",
        "Tungsten",
        "Palladium",
        "Tin",
        "Bronze",
        "Pewter",
        "Sterling Silver"
    ]
    
    private static let Materials = [
        "Wooden",
        "Copper",
        "Brass",
        "Bronze",
        "Silver",
        "Gold",
        "Quartz",
        "Glass",
        "Rubber",
        "Bone"
    ]
    
    private static let Topics = [
        "Philosophy",
        "Metaphysics",
        "Magic",
        "Animals",
        "Plants",
        "Mushrooms",
        "Insects",
        "Machines",
        "Mathematics",
        "Statistics",
        "Logic",
        "Geology",
        "Astronomy",
        "Meteorology",
        "Alchemy",
        "History",
        "The Dead",
        "Business Administration",
        "Law",
        "Medicene",
        "Herbs",
        "Spices",
        "Herbs and Spices",
        "Illustrated Recipes",
        "Art",
        "Architecture",
        "Mystery",
        "Known Felons",
        "Known Time Travelers",
        "Kings",
        "Queens",
        "Gardening",
        "Engineering",
        "Monsters",
        "Wizardry"
    ]
    
    private static let Mails = [
        "Fur",
        "Leather",
        "Bone",
        "Scale Mail",
        "Plate Mail",
        "Chain Mail",
        "Banded Mail"
    ]
    
    public enum Kind:Int,CustomStringConvertible {
        
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
        case utensil
        
        public var description:String {
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
            case utensil: return "Utensil"
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

