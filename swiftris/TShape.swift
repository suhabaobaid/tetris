//
//  TShape.swift
//  swiftris
//
//  Created by Suha Baobaid on 28/07/2017.
//  Copyright © 2017 Suha Baobaid. All rights reserved.
//

class TShape: Shape {
    
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero: [(1,0), (0,1), (1,1), (2,1)],
            Orientation.OneEighty: [(2,1), (1,0), (1,1), (1,2)],
            Orientation.Ninety: [(1,2), (0,1), (1,1), (2,1)],
            Orientation.TwoSeventy: [(0,1), (1,0), (1,1), (1,2)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>] {
        return [
            Orientation.Zero: [blocks[SecondBlockIdx], blocks[ThirdBlockIdx]],
            Orientation.OneEighty: [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety: [blocks[FirstBlockIdx], blocks[SecondBlockIdx]],
            Orientation.TwoSeventy: [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
        ]
    }
}
