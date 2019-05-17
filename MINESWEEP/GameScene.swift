//
//  GameScene.swift
//  MINESWEEP
//
//  Created by Tyler Chan on 4/10/19.
//  Copyright © 2019 Tyler Chan. All rights reserved.
//

import SpriteKit
import GameplayKit

var flagMode = false;

class GameScene: SKScene {
    
    let background = Background()
    let smile = Smile();
    var tile = Tile()
    var grid = [[Tile]]()
    var gridSizeX = 11;
    var gridSizeY = 21;
    var gameOver = false;
    var flagOutlet : UIButton?
    var mines = 60;
    
    override func didMove(to view: SKView) {
        setup()
    }
    
    func setup() {
        smile.smile.texture = SKTexture(imageNamed: "Smile")
        self.removeAllChildren()
        gameOver = false;
        self.addChild(background.background)
        self.addChild(smile.smile)
        grid = [[Tile]]()
        flagOutlet?.isEnabled = true;
        for x in 0 ... 10 {
            var row = [Tile]()
            for y in 0 ... 20 {
                row.append(Tile())
                self.addChild(row[y])
                row[y].position = CGPoint(x: (Double(x) * 52.2) - 260, y: (Double(y) * 52.2) - 565)
                row[y].gameScene = self;
            }
            grid.append(row)
        }
        for _ in 0 ... 59 {
            let randomX = Int.random(in: 0 ... 10);
            let randomY = Int.random(in: 0 ... 20);
            grid[randomX][randomY].mine = true;
            mines += 1;
        }
        for x in 0 ... gridSizeX-1 {
            for y in 0 ... gridSizeY-1 {
                var tCount = 0;
                if x > 0 {
                    if grid[x-1][y].mine {
                        tCount += 1;
                    }
                    grid[x][y].neighbors.append(grid[x-1][y])
                }
                if x < gridSizeX-1 {
                    if grid[x+1][y].mine {
                        tCount += 1;
                    }
                    grid[x][y].neighbors.append(grid[x+1][y])
                }
                if y > 0 {
                    if grid[x][y-1].mine {
                        tCount += 1;
                    }
                    grid[x][y].neighbors.append(grid[x][y-1])
                }
                if y < gridSizeY-1 {
                    if grid[x][y+1].mine {
                        tCount += 1;
                    }
                    grid[x][y].neighbors.append(grid[x][y+1])
                }
                if x > 0 && y > 0 {
                    if grid[x-1][y-1].mine {
                        tCount += 1;
                    }
                    grid[x][y].neighbors.append(grid[x-1][y-1])
                }
                if x > 0 && y < gridSizeY-1 {
                    if grid[x-1][y+1].mine {
                        tCount += 1;
                    }
                    grid[x][y].neighbors.append(grid[x-1][y+1])
                }
                if x < gridSizeX-1 && y > 0 {
                    if grid[x+1][y-1].mine {
                        tCount += 1;
                    }
                    grid[x][y].neighbors.append(grid[x+1][y-1])
                }
                if x < gridSizeX-1 && y < gridSizeY-1 {
                    if grid[x+1][y+1].mine {
                        tCount += 1;
                    }
                    grid[x][y].neighbors.append(grid[x+1][y+1])
                }
                grid[x][y].count = tCount;
            }
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if gameOver == true || winFunc() == true {
            return
        }
        let touched = self.nodes(at: pos)
        for tile in touched {
            if tile.name == "Tile" {
                smile.smile.texture = SKTexture(imageNamed: "OpenSmile")
                let cTile = tile as! Tile;
                cTile.change()
                if cTile.mine && cTile.isFlagged == false {
                    explode()
                }
            }
        }
        if winFunc() {
            smile.smile.texture = SKTexture(imageNamed: "WinSmile")
            flagOutlet?.isEnabled = false;
        }
    }
    
    func explode() {
        for row in grid {
            for tile in row {
                if flagMode == false {
                    if tile.mine && tile.isFlagged == false {
                        flagOutlet?.isEnabled = false;
                        gameOver = true;
                        smile.smile.texture = SKTexture(imageNamed: "DeadSmile")
                        tile.change()
                    } else if tile.isFlagged == true && tile.mine == false {
                        tile.texture = SKTexture(imageNamed: "NotMine")
                    }
                }
            }
        }
    }
    
    func winFunc() -> Bool {
        for row in grid {
            for tile in row {
                if tile.isClicked == false && tile.mine == false {
                    return false;
                }
            }
        }
        return true;
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
        smile.smile.texture = SKTexture(imageNamed: "Smile")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
