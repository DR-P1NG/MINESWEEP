//
//  Background.swift
//  MINESWEEP
//
//  Created by Tyler Chan on 5/16/19.
//  Copyright © 2019 Tyler Chan. All rights reserved.
//

import Foundation
import SpriteKit

class Background {
    var background = SKSpriteNode(imageNamed: "Background")
    
    init() {
        var screenWidth : CGFloat {
            return UIScreen.main.bounds.width;
        }
        
        var screenHeight : CGFloat {
            return UIScreen.main.bounds.height;
        }
        
        let width = UIScreen.main.bounds.width;
        let height = UIScreen.main.bounds.height;
        
        print(height,width)
        
        background.position = CGPoint(x: 0, y: 0)
        background.size = CGSize(width: 620, height: 1220)
        background.zPosition = -100
    }
}
