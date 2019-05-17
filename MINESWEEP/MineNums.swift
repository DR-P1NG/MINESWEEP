//
//  MineNums.swift
//  MINESWEEP
//
//  Created by Tyler Chan on 5/17/19.
//  Copyright © 2019 Tyler Chan. All rights reserved.
//

import Foundation
import SpriteKit

class MineNums {
    var digit1 = SKSpriteNode(imageNamed: "Num0")
    var digit2 = SKSpriteNode(imageNamed: "Num0")
    var digit3 = SKSpriteNode(imageNamed: "Num0")
    var digit4 = SKSpriteNode(imageNamed: "Num0")
    var digit5 = SKSpriteNode(imageNamed: "Num0")
    var digit6 = SKSpriteNode(imageNamed: "Num0")
    
    init() {
        digit1.position = CGPoint(x: -200, y: 560)
        digit1.size = CGSize(width: 25, height: 44)
        digit1.zPosition = 50;
        
        digit2.position = CGPoint(x: -229, y: 560)
        digit2.size = CGSize(width: 25, height: 44)
        digit2.zPosition = 50;

        digit3.position = CGPoint(x: -258, y: 560)
        digit3.size = CGSize(width: 25, height: 44)
        digit3.zPosition = 50;

        digit4.position = CGPoint(x: 198, y: 560)
        digit4.size = CGSize(width: 25, height: 44)
        digit4.zPosition = 50;
        
        digit5.position = CGPoint(x: 225, y: 560)
        digit5.size = CGSize(width: 25, height: 44)
        digit5.zPosition = 50;
        
        digit6.position = CGPoint(x: 254, y: 560)
        digit6.size = CGSize(width: 25, height: 44)
        digit6.zPosition = 50;
    }
    
    func setNum(num : Int, time : Int) {
        digit6.texture = SKTexture(imageNamed: "Num" + String(time%10))
        digit5.texture = SKTexture(imageNamed: "Num" + String((time/10)%10))
        digit4.texture = SKTexture(imageNamed: "Num" + String(time/100))
        if num >= 0 {
            digit1.texture = SKTexture(imageNamed: "Num" + String(num%10))
            digit2.texture = SKTexture(imageNamed: "Num" + String(num/10))
            digit3.texture = SKTexture(imageNamed: "Num0")
        } else if num < 0 {
            digit1.texture = SKTexture(imageNamed: "Num" + String(abs(num)%10))
            digit2.texture = SKTexture(imageNamed: "Num" + String(abs(num)/10))
            digit3.texture = SKTexture(imageNamed: "Num")
        }
    }
}
