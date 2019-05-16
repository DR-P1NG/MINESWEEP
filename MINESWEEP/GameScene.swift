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
    var tile = Tile()
    var grid = [[Tile]]()
    var gridSizeX = 11;
    var gridSizeY = 21;
    var gameOver = false;
    var flagOutlet : UIButton?
    
    override func didMove(to view: SKView) {
        setup()
    }
    
    func setup() {
        self.removeAllChildren()
        gameOver = false;
        self.addChild(background.background)
        grid = [[Tile]]()
        flagOutlet?.isEnabled = true;
        for x in 0 ... 10 {
            var row = [Tile]()
            for y in 0 ... 20 {
                row.append(Tile())
                self.addChild(row[y])
                row[y].position = CGPoint(x: (Double(x) * 52.2) - 260, y: (Double(y) * 52.2) - 565)
            }
            grid.append(row)
        }
        for _ in 0 ... 59 {
            let randomX = Int.random(in: 0 ... 10);
            let randomY = Int.random(in: 0 ... 20);
            grid[randomX][randomY].mine = true;
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
        if gameOver == true {
            return
        }
        let touched = self.nodes(at: pos)
        for tile in touched {
            if tile.name == "Tile" {
                let cTile = tile as! Tile;
                cTile.change()
                if cTile.mine && cTile.isFlagged == false {
                    for row in grid {
                        for tile in row {
                            if flagMode == false {
                                if tile.mine && tile.isFlagged == false {
                                    flagOutlet?.isEnabled = false;
                                    gameOver = true;
                                    tile.change()
                                } else if tile.isFlagged == true && tile.mine == false {
                                    tile.texture = SKTexture(imageNamed: "NotMine")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func explode() {
        //idk
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
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
