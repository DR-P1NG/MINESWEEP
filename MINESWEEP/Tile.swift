//
//  File.swift
//  MINESWEEP
//
//  Created by Tyler Chan on 4/12/19.
//  Copyright © 2019 Tyler Chan. All rights reserved.
//

import Foundation
import SpriteKit

class Tile: SKSpriteNode {
    let tex = SKTexture(imageNamed: "Tile")
    var mine : Bool = false;
    var neighbors = [Tile]()
    var count = 0;
    var isFlagged = false;
    var isClicked = false;
    var gameScene : GameScene?
    
    init () {
        super.init(texture: tex, color: UIColor.clear, size: CGSize(width: 50, height: 50))
        self.name = "Tile"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func change(){
        let num = String(count)
        if isClicked {
            var tCount = 0
            for n in neighbors {
                if n.isFlagged {
                    tCount += 1;
                }
            }
            if tCount == count && mine == false && flagMode == false {
                for n in neighbors {
                    if !n.isClicked {
                        n.change()
                    }
                    if n.mine {
                        gameScene?.explode()
                    }
                }
            }
        }
        if flagMode == true {
            if isClicked == false {
                self.texture = SKTexture(imageNamed: "Flag")
                if isFlagged == true {
                    self.texture = SKTexture(imageNamed: "Tile")
                }
                isFlagged = !isFlagged
            }
        } else if isFlagged == false {
            if mine == true {
                self.texture = SKTexture(imageNamed: "Mine")
            } else {
                self.texture = SKTexture(imageNamed: num)
            }
            isClicked = true;
        }
        if count == 0 && flagMode == false && mine == false && isFlagged == false {
            for neighbor in neighbors {
                if neighbor.isClicked == false {
                    neighbor.change()
                }
            }
        }
    }
}


