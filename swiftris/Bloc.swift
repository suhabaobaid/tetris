//
//  Bloc.swift
//  swiftris
//
//  Created by Suha Baobaid on 27/07/2017.
//  Copyright © 2017 Suha Baobaid. All rights reserved.
//

import SpriteKit

let NumberOfColors: UInt32 = 6
enum BlockColor: Int, CustomStringConvertible {
    case Blue = 0, Orange, Purple, Red, Teal, Yellow
    //This is a computed property, its value is computed each time it is called
    //by the function
    var spriteName: String {
        switch self {
        case .Blue:
            return "blue"
        case .Orange:
            return "orange"
        case .Purple:
            return "purple"
        case .Red:
            return "red"
        case .Teal:
            return "Teal"
        case .Yellow:
            return "yellow"
        }
    }

    var description: String {
        return self.spriteName
    }

    static func random() -> BlockColor {
        return BlockColor(rawValue: Int(arc4random_uniform(NumberOfColors)))!
    }
}

class Block: Hashable, CustomStringConvertible {
    let color: BlockColor

    var column: Int
    var row: Int

    //This represents the visual element of the Block which GameScene will use to render and animate each Block
    var sprite: SKSpriteNode?

    var spriteName: String {
        return color.spriteName
    }

    var hashValue: Int {
        return self.column ^ self.row
    }

    var description: String {
        return "\(color): [\(column), \(row)]"
    }

    init(column: Int, row: Int, color: BlockColor) {
        self.column = column
        self.row = row
        self.color = color
    }
}

func == (lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}
