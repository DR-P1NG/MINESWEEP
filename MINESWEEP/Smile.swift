//
//  Smile.swift
//  MINESWEEP
//
//  Created by Tyler Chan on 5/16/19.
//  Copyright © 2019 Tyler Chan. All rights reserved.
//

import Foundation
import SpriteKit

class Smile {
    var smile = SKSpriteNode(imageNamed: "Smile")
    
    init() {
        smile.position = CGPoint(x: -2, y: 559)
        smile.size = CGSize(width: 57, height: 57)
        smile.zPosition = 50;
    }
}
