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
        let kind = Kind.oneAtRandom()
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

    private func makeWeapon() {
        
        let style = Int(arc4random_uniform(2))
        
        _descriptor.append(value: style)

        _descriptor.append(index: Loot.Weights.oneIndexAtRandom(nilStrategy: .equalChance))
        
        switch style {
        
        case 0: _descriptor.append(index: Loot.Races.oneIndexAtRandom(nilStrategy: .equalChance))
        
        case 1: _descriptor.append(index: Loot.Materials.oneIndexAtRandom(nilStrategy: .equalChance))
        
        default:break
        
        }
        
        _descriptor.append(index: Loot.Weapons.oneIndexAtRandom())
    }
    
    private func describeWeapon(iterator:DescriptorIterator) throws -> String {
        
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
    
    private func makeArmor() {
        
        let style = Int(arc4random_uniform(2))
        
        _descriptor.append(value: style)
        
        switch style {
            
        case 0:
            _descriptor.append(index: Loot.Aspects.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Races.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Mails.oneIndexAtRandom())
            _descriptor.append(index: Loot.Armors.oneIndexAtRandom())
            
        case 1:
            _descriptor.append(index: Loot.Aspects.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Races.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Materials.oneIndexAtRandom())
            
        default:break
            
        }
    }

    private func describeArmor(iterator:DescriptorIterator) throws -> String {
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let aspect = try iterator.nextOptionalItem(Loot.Aspects)
            let race = try iterator.nextOptionalItem(Loot.Races)
            let mail = try iterator.nextItem(Loot.Mails)
            let armor = try iterator.nextItem(Loot.Armors)
            return postProcess("\(aspect) \(race) \(mail) \(armor)")
            
        case 1:
            let aspect = try iterator.nextOptionalItem(Loot.Aspects)
            let race = try iterator.nextOptionalItem(Loot.Races)
            let material = try iterator.nextItem(Loot.Materials)
            return postProcess("\(aspect) \(race) \(material) ^shield")
            
        default:
            return ""
        }
    }
    
    private func makeMonsterPart() {
        
        _descriptor.append(index: Loot.Colors.oneIndexAtRandom())
        _descriptor.append(index: Loot.MonsterParts.oneIndexAtRandom())
    }
    
    private func describeMonsterPart(iterator:DescriptorIterator) throws -> String {
        
        let color = try iterator.nextItem(Loot.Colors)
        let part = try iterator.nextItem(Loot.MonsterParts)
        return postProcess("\(color) monster \(part)")
    }
    
    private func makeTool() {
        _descriptor.append(index: Loot.Weights.oneIndexAtRandom(nilStrategy: .equalChance))
        _descriptor.append(index: Loot.Metals.oneIndexAtRandom())
        _descriptor.append(index: Loot.Tools.oneIndexAtRandom())
    }
    
    private func describeTool(iterator:DescriptorIterator) throws -> String {
        let weight = try iterator.nextOptionalItem(Loot.Weights)
        let metal = try iterator.nextItem(Loot.Metals)
        let tool = try iterator.nextItem(Loot.Tools)
        return postProcess("\(weight) \(metal) \(tool)")
    }
    
    private func makeScroll() {
        _descriptor.append(index: Loot.Enchantments.oneIndexAtRandom(nilStrategy: .probability(value:0.80)))
        _descriptor.append(index: Loot.Characteristics.oneIndexAtRandom())
    }
    
    private func describeScroll(iterator:DescriptorIterator) throws -> String {
        let enchantment = try iterator.nextOptionalItem(Loot.Enchantments)
        let characteristic = try iterator.nextItem(Loot.Characteristics)
        return postProcess("\(enchantment) ^scroll of \(characteristic)")
    }
    
    private func makeWand() {
        let style = Int(arc4random_uniform(2))
        
        _descriptor.append(value: style)
        _descriptor.append(index: Loot.Enchantments.oneIndexAtRandom(nilStrategy: .probability(value:0.90)))

        switch style {
        
        case 0:
            _descriptor.append(index: Loot.Materials.oneIndexAtRandom())
        case 1:
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom())
        default:
            break
        }

        _descriptor.append(index: Loot.Characteristics.oneIndexAtRandom())
    }
    
    private func describeWand(iterator:DescriptorIterator) throws -> String {
        
        let style:Int = try iterator.next()
        let enchantment = try iterator.nextOptionalItem(Loot.Enchantments)

        switch style {
        case 0:
            let material = try iterator.nextItem(Loot.Materials)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return postProcess("\(enchantment) \(material) ^wand of \(characteristic)")
        case 1:
            let metal = try iterator.nextItem(Loot.Metals)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return postProcess("\(enchantment) \(metal) ^wand of \(characteristic)")
        default:
            return ""
        }
    }
    
    private func makePotion() {
        _descriptor.append(index: Loot.Colors.oneIndexAtRandom())
        _descriptor.append(index: Loot.Characteristics.oneIndexAtRandom())
    }
    
    private func describePotion(iterator:DescriptorIterator) throws -> String {
        let color = try iterator.nextItem(Loot.Colors)
        let characteristic = try iterator.nextItem(Loot.Characteristics)
        return postProcess("\(color) ^potion of \(characteristic)")
    }
    
    private func makeAmulet() {
        
        let randomStyle = arc4random_uniform(4001)
        let style = (randomStyle != 4000)
            ? Int(randomStyle / 1000)
            : 4
        
        _descriptor.append(value: style)
        
        switch style {

        case 0:
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom())
        
        case 1:
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom(nilStrategy: .equalChance))
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
    
    private func describeAmulet(iterator:DescriptorIterator) throws -> String {
        
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let metal = try iterator.nextItem(Loot.Metals)
            return postProcess("\(metal) ^amulet")
            
        case 1:
            let metal = try iterator.nextOptionalItem(Loot.Metals)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return postProcess("\(metal) ^amulet of \(characteristic)")
            
        case 2:
            let gem = try iterator.nextItem(Loot.Gems)
            return postProcess("\(gem) ^amulet")
            
        case 3:
            let gem = try iterator.nextItem(Loot.Gems)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return postProcess("\(gem) ^amulet of \(characteristic)")
            
        case 4:
            return "The Amulet of Yendor"
            
        default:
            return ""
            
        }
    }
    
    private func makeRing() {
        let style = Int(arc4random_uniform(6))
        
        _descriptor.append(value: style)
        
        switch style {
            
        case 0:
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom())
            
        case 1:
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Characteristics.oneIndexAtRandom())
            
        case 2:
            _descriptor.append(index: Loot.Gems.oneIndexAtRandom())
            
        case 3:
            _descriptor.append(index: Loot.Gems.oneIndexAtRandom())
            _descriptor.append(index: Loot.Characteristics.oneIndexAtRandom())
           
        case 4:
            _descriptor.append(index: Loot.Gems.oneIndexAtRandom())
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom())
            
        case 5:
            _descriptor.append(index: Loot.Gems.oneIndexAtRandom())
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Characteristics.oneIndexAtRandom())
            
        default:
            break
        }
        
    }
    
    private func describeRing(iterator:DescriptorIterator) throws -> String {
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let metal = try iterator.nextItem(Loot.Metals)
            return postProcess("\(metal) ^ring")
            
        case 1:
            let metal = try iterator.nextOptionalItem(Loot.Metals)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return postProcess("\(metal) ^ring of \(characteristic)")
            
        case 2:
            let gem = try iterator.nextItem(Loot.Gems)
            return postProcess("\(gem) ^ring")
            
        case 3:
            let gem = try iterator.nextItem(Loot.Gems)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return postProcess("\(gem) ^ring of \(characteristic)")
            
        case 4:
            let gem = try iterator.nextItem(Loot.Gems)
            let metal = try iterator.nextItem(Loot.Metals)
            return postProcess("\(gem) encrusted \(metal) ^ring")

        case 5:
            let gem = try iterator.nextItem(Loot.Gems)
            let metal = try iterator.nextOptionalItem(Loot.Metals)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return postProcess("\(gem) encrusted \(metal) ^ring of \(characteristic)")
            
        default:
            return ""
            
        }
    }
    
    private func makeBracelet() {
        let style = Int(arc4random_uniform(4))
        
        _descriptor.append(value: style)
        
        switch style {
            
        case 0:
            _descriptor.append(index: Loot.Weights.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom())
            
        case 1:
            _descriptor.append(index: Loot.Weights.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Characteristics.oneIndexAtRandom())
            
        case 2:
            _descriptor.append(index: Loot.Gems.oneIndexAtRandom())
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom())
            
        case 3:
            _descriptor.append(index: Loot.Gems.oneIndexAtRandom())
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Characteristics.oneIndexAtRandom())
            
        default:
            break
        }
    }
    
    private func describeBracelet(iterator:DescriptorIterator) throws -> String {
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let weight = try iterator.nextOptionalItem(Loot.Weights)
            let metal = try iterator.nextItem(Loot.Metals)
            return postProcess("\(weight) \(metal) ^bracelet")
            
        case 1:
            let weight = try iterator.nextOptionalItem(Loot.Weights)
            let metal = try iterator.nextOptionalItem(Loot.Metals)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return postProcess("\(weight) \(metal) ^bracelet of \(characteristic)")
            
        case 2:
            let gem = try iterator.nextItem(Loot.Gems)
            let metal = try iterator.nextItem(Loot.Metals)
            return postProcess("\(gem) encrusted \(metal) ^bracelet")
            
        case 3:
            let gem = try iterator.nextItem(Loot.Gems)
            let metal = try iterator.nextOptionalItem(Loot.Metals)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return postProcess("\(gem) encrusted \(metal) ^bracelet of \(characteristic)")

        default:
            return ""
            
        }
    }
    
    private func makeNecklace() {
        let style = Int(arc4random_uniform(4))
        
        _descriptor.append(value: style)
        
        switch style {
            
        case 0:
            _descriptor.append(index: Loot.Weights.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom())
            
        case 1:
            _descriptor.append(index: Loot.Weights.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Characteristics.oneIndexAtRandom())
            
        case 2:
            _descriptor.append(index: Loot.Gems.oneIndexAtRandom())
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom())
            
        case 3:
            _descriptor.append(index: Loot.Gems.oneIndexAtRandom())
            _descriptor.append(index: Loot.Metals.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Characteristics.oneIndexAtRandom())
            
        default:
            break
        }
    }
    
    private func describeNecklace(iterator:DescriptorIterator) throws -> String {
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let weight = try iterator.nextOptionalItem(Loot.Weights)
            let metal = try iterator.nextItem(Loot.Metals)
            return postProcess("\(weight) \(metal) ^necklace")
            
        case 1:
            let weight = try iterator.nextOptionalItem(Loot.Weights)
            let metal = try iterator.nextOptionalItem(Loot.Metals)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return postProcess("\(weight) \(metal) ^necklace of \(characteristic)")
            
        case 2:
            let gem = try iterator.nextItem(Loot.Gems)
            let metal = try iterator.nextItem(Loot.Metals)
            return postProcess("\(gem) encrusted \(metal) ^necklace")
            
        case 3:
            let gem = try iterator.nextItem(Loot.Gems)
            let metal = try iterator.nextOptionalItem(Loot.Metals)
            let characteristic = try iterator.nextItem(Loot.Characteristics)
            return postProcess("\(gem) encrusted \(metal) ^necklace of \(characteristic)")
            
        default:
            return ""
            
        }
    }
    
    private func makeStaff() {
        let style = Int(arc4random_uniform(4))
        
        _descriptor.append(value: style)
        
        switch style {
            
        case 0:
            _descriptor.append(index: Loot.Materials.oneIndexAtRandom())
            
        case 1:
            _descriptor.append(index: Loot.Materials.oneIndexAtRandom())
            
        case 2:
            _descriptor.append(index: Loot.Gems.oneIndexAtRandom())
            _descriptor.append(index: Loot.Materials.oneIndexAtRandom())
            
        case 3:
            _descriptor.append(index: Loot.Gems.oneIndexAtRandom())
            _descriptor.append(index: Loot.Materials.oneIndexAtRandom())
            
        default:
            break
        }
    }
    
    private func describeStaff(iterator:DescriptorIterator) throws -> String {
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let material = try iterator.nextItem(Loot.Materials)
            return postProcess("\(material) ^rod")
            
        case 1:
            let material = try iterator.nextItem(Loot.Materials)
            return postProcess("\(material) ^staff")
            
        case 2:
            let gem = try iterator.nextItem(Loot.Gems)
            let material = try iterator.nextItem(Loot.Materials)
            return postProcess("\(gem) encrusted \(material) ^rod")
            
        case 3:
            let gem = try iterator.nextItem(Loot.Gems)
            let material = try iterator.nextItem(Loot.Materials)
            return postProcess("\(gem) encrusted \(material) ^staff")
            
        default:
            return ""
            
        }
    }
    
    private func makeKey() {
        _descriptor.append(index: Loot.Aspects.oneIndexAtRandom(nilStrategy: .equalChance))
        _descriptor.append(index: Loot.Materials.oneIndexAtRandom())
        
    }
    
    private func describeKey(iterator:DescriptorIterator) throws -> String {
        let aspect = try iterator.nextOptionalItem(Loot.Aspects)
        let material = try iterator.nextItem(Loot.Materials)
        return postProcess("\(aspect) \(material) ^key")
    }
    
    private func makeAmmunition() {
        let style = Int(arc4random_uniform(4))
        
        _descriptor.append(value: style)
        _descriptor.append(index: Loot.Aspects.oneIndexAtRandom(nilStrategy: .equalChance))
        _descriptor.append(index: Loot.Materials.oneIndexAtRandom())
    }
    
    private func describeAmmunition(iterator:DescriptorIterator) throws -> String {
        
        let style:Int = try iterator.next()
        let aspect = try iterator.nextOptionalItem(Loot.Aspects)
        let material = try iterator.nextItem(Loot.Materials)
        
        if style == 0 {
            return postProcess("\(aspect) \(material) ^arrow")
        }
        
        return postProcess("\(aspect) \(material) ^bolt")
    }
    
    private func makeGemstone() {

        _descriptor.append(index: Loot.Sizes.oneIndexAtRandom())
        _descriptor.append(index: Loot.Aspects.oneIndexAtRandom(nilStrategy: .equalChance))
        _descriptor.append(index: Loot.Colors.oneIndexAtRandom())
    }
    
    private func describeGemstone(iterator:DescriptorIterator) throws -> String {

        let size = try iterator.nextItem(Loot.Sizes)
        let aspect = try iterator.nextOptionalItem(Loot.Aspects)
        let color = try iterator.nextItem(Loot.Colors)
        return postProcess("\(size) \(aspect) \(color) ^gem")
    }
    
    private func makeOre() {
        _descriptor.append(index: Loot.Masses.oneIndexAtRandom())
        _descriptor.append(index: Loot.MetalElements.oneIndexAtRandom())
    }
    
    private func describeOre(iterator:DescriptorIterator) throws -> String {
        let mass = try iterator.nextItem(Loot.Masses)
        let element = try iterator.nextItem(Loot.MetalElements)
        return postProcess("\(mass) of \(element) ore")
    }
    
    private func makeClothes() {
        _descriptor.append(index: Loot.Sizes.oneIndexAtRandom(nilStrategy: .equalChance))
        _descriptor.append(index: Loot.Aspects.oneIndexAtRandom(nilStrategy: .equalChance))
        _descriptor.append(index: Loot.Colors.oneIndexAtRandom())
        _descriptor.append(index: Loot.Clothes.oneIndexAtRandom())
    }
    
    private func describeClothes(iterator:DescriptorIterator) throws -> String {
        let size = try iterator.nextOptionalItem(Loot.Sizes)
        let aspect = try iterator.nextOptionalItem(Loot.Aspects)
        let color = try iterator.nextItem(Loot.Colors)
        let clothing = try iterator.nextItem(Loot.Clothes)
        return postProcess("\(size) \(aspect) \(color) \(clothing)")
    }
    
    private func makeBook() {
        let style = Int(arc4random_uniform(3))
        
        _descriptor.append(value: style)
        
        switch style {
            
        case 0:
            _descriptor.append(index: Loot.Sizes.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Colors.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Topics.oneIndexAtRandom())
            
        case 1:
            _descriptor.append(index: Loot.Lengths.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Colors.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Topics.oneIndexAtRandom())
            
        case 2:
            _descriptor.append(index: Loot.Weights.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Colors.oneIndexAtRandom(nilStrategy: .equalChance))
            _descriptor.append(index: Loot.Topics.oneIndexAtRandom())
            
        default:
            break
        }
    }
    
    private func describeBook(iterator:DescriptorIterator) throws -> String {
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let size = try iterator.nextOptionalItem(Loot.Sizes)
            let color = try iterator.nextOptionalItem(Loot.Colors)
            let topic = try iterator.nextItem(Loot.Topics)
            return postProcess("\(size) \(color) ^book of \(topic)")
            
        case 1:
            let length = try iterator.nextOptionalItem(Loot.Lengths)
            let color = try iterator.nextOptionalItem(Loot.Colors)
            let topic = try iterator.nextItem(Loot.Topics)
            return postProcess("\(length) \(color) ^book of \(topic)")
            
        case 2:
            let weight = try iterator.nextOptionalItem(Loot.Weights)
            let color = try iterator.nextOptionalItem(Loot.Colors)
            let topic = try iterator.nextItem(Loot.Topics)
            return postProcess("\(weight) \(color) ^book of \(topic)")
            
        default:
            return ""
            
        }
    }
    
    private func makeUtensil() {
        
        _descriptor.append(index: Loot.Aspects.oneIndexAtRandom(nilStrategy: .equalChance))
        _descriptor.append(index: Loot.Materials.oneIndexAtRandom())
        _descriptor.append(index: Loot.Utensils.oneIndexAtRandom())
        
    }
    
    private func describeUtensil(iterator:DescriptorIterator) throws -> String {
        
        let aspect = try iterator.nextOptionalItem(Loot.Aspects)
        let material = try iterator.nextItem(Loot.Materials)
        let utensil = try iterator.nextItem(Loot.Utensils)
        
        return postProcess("\(aspect) \(material) \(utensil)")
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
                
                let quantityText = text.starts(withAny: Loot.VowelPrefixes)
                    ? "An"
                    : "A"
                
                return "\(quantityText) \(text)"
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
            
        } else {
            let firstLetter = text.characters.first!
            let capitalLetter = String(firstLetter).capitalized
            text.remove(at: text.startIndex)
            text.insert(capitalLetter.characters.first!, at: text.startIndex)
        }
        
        return text
    }
    
    private static let Weapons = [
        "^dagger",
        "^knife",
        "^axe",
        "short ^sword",
        "^broadsword",
        "long ^sword",
        "^katana",
        "^saber",
        "^club",
        "^mace",
        "morning ^star",
        "^flail",
        "^quarterstaff",
        "^polearm",
        "^spear",
        "^bow",
        "^crossbow"
    ]
    
    private static let Armors = [
        "armor ^set",
        "gauntlets",
        "^helm",
        "boots"
    ]
    
    private static let MonsterParts = [
        "^hide",
        "^fur",
        "^tusk",
        "^horn",
        "^tooth",
        "^bone"
    ]
    
    private static let Tools = [
        "^saw",
        "^axe",
        "scissors",
        "^hammer",
        "^wrench",
        "pliers"
    ]
    
    private static let Clothes = [
        "^shirt",
        "trousers",
        "^shorts",
        "capris",
        "^skirt",
        "^robe",
        "^hood",
        "^glove",
        "^dress",
        "^jacket",
        "^vest",
        "pajamas",
        "^scarf",
        "^coat",
        "^cap",
        "^cape",
        "^mask",
        "^headband"
    ]
    
    private static let Utensils = [
        "^fork",
        "^spoon",
        "^knife"
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
        "shimmering",
        "sparkling",
        "glittering",
        "incandescent",
        "glowing",
        "dirty",
        "dingy",
        "shabby",
        "faded",
        "bright",
        "flawless",
        "translucent",
        "cloudy"
    ]
    
    private static let Characteristics = [
        "healing",
        "pain",
        "agony",
        "hunger",
        "strength",
        "agility",
        "stamina",
        "intellect",
        "teleportation",
        "protection",
        "invisibility",
        "speed",
        "slowness",
        "heaviness",
        "lightness",
        "blundering",
        "clumsiness",
        "dexterity",
        "sleepiness",
        "hate",
        "amore",
        "vigor",
        "itching",
        "accuracy",
        "cowardice",
        "inebriation",
        "sobriety",
        "endurance",
        "persuasion",
        "polymorphism",
        "blindness"
    ]
    
    private static let Gems = [
        "ruby",
        "diamond",
        "quartz",
        "emerald",
        "jade",
        "opal",
        "onyx",
        "pearl",
        "sapphire",
        "topaz",
        "turquoise",
        "cubit zirconia"
    ]
    
    private static let Lengths = [
        "short",
        "medium",
        "long"
    ]
    
    private static let Sizes = [
        "very small",
        "small",
        "medium",
        "large",
        "extra large",
        "extremely large"
    ]
    
    private static let Weights = [
        "weightless",
        "very light",
        "light",
        "heavy",
        "very heavy",
        "extremely heavy"
    ]
    
    public static let Colors = [
        "white",
        "azure",
        "blue",
        "aquamarine",
        "crimson",
        "red",
        "brown",
        "golden",
        "green",
        "gray",
        "lavendar",
        "pink",
        "indigo",
        "green",
        "cream",
        "eggshell",
        "beige",
        "ecru",
        "turquoise",
        "tan",
        "teal",
        "yellow",
        "purple",
        "magenta",
        "cornflower blue"
    ]
    
    private static let MetalElements = [
        "aluminum",
        "titanium",
        "vanadium",
        "chromium",
        "manganese",
        "iron",
        "cobalt",
        "nickel",
        "copper",
        "zinc",
        "gallium",
        "yttrium",
        "zirconium",
        "niobium",
        "molybdenum",
        "ruthenium",
        "rhodium",
        "palladium",
        "silver",
        "cadmium",
        "indium",
        "tin",
        "hafnium",
        "tantalum",
        "tungsten",
        "rhenium",
        "osmium",
        "iridium",
        "platinum",
        "gold",
        "thallium",
        "lead",
        "bismuth",
        "polonium",
        "thorium",
        "uranium",
        "plutonium"
    ]
    
    private static let Metals = [
        "aluminum",
        "titanium",
        "iron",
        "cast iron",
        "silver",
        "gold",
        "rose gold",
        "white gold",
        "platinum",
        "copper",
        "steel",
        "brass",
        "nickel",
        "zinc",
        "tungsten",
        "palladium",
        "tin",
        "bronze",
        "pewter",
        "sterling silver"
    ]
    
    private static let Materials = [
        "wooden",
        "copper",
        "brass",
        "bronze",
        "silver",
        "gold",
        "quartz",
        "glass",
        "rubber",
        "bone"
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
        "fur",
        "leather",
        "bone",
        "scale mail",
        "plate mail",
        "chain mail",
        "banded mail"
    ]
    
    private static let VowelPrefixes = [
        "alum",
        "aqua",
        "azur",
        "ecru",
        "eggs",
        "Elve",
        "emer",
        "endu",
        "extr",
        "inca",
        "indi",
        "irid",
        "iron",
        "onyx",
        "opal",
        "Orci",
        "osmi",
        "Unde"
    ]
    
    private static let Enchantments = [
        "blessed",
        "cursed"
    ]

    private static let Masses = [
        "^milligram",
        "^gram",
        "^kilogram"
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
            case weapon: return "weapon"
            case armor: return "armor"
            case monsterPart: return "monster part"
            case tool: return "tool"
            case scroll: return "scroll"
            case wand: return "wand"
            case potion: return "potion"
            case amulet: return "amulet"
            case ring: return "ring"
            case bracelet: return "bracelet"
            case necklace: return "necklace"
            case staff: return "staff"
            case key: return "key"
            case ammunition: return "ammunition"
            case gemstone: return "gemstone"
            case ore: return "ore"
            case clothes: return "clothes"
            case book: return "book"
            case utensil: return "utensil"
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

