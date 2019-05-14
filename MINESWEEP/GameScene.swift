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
    
    var tile = Tile()
    var grid = [[Tile]]()
    var gridSize = 6;
    
    override func didMove(to view: SKView) {
        //self.addChild(mine.sprite)
        for x in 0 ... 5 {
            var row = [Tile]()
            for y in 0 ... 5 {
                row.append(Tile())
                self.addChild(row[y])
                row[y].position = CGPoint(x: (Double(x) * 50.0) - 100, y: (Double(y) * 50.0) - 100)
            }
            grid.append(row)
            }
        for _ in 0 ... 6 {
            let randomX = Int.random(in: 0 ... 5);
            let randomY = Int.random(in: 0 ... 5);
            grid[randomX][randomY].mine = true;
        }
        for x in 0 ... gridSize-1 {
            for y in 0 ... gridSize-1 {
                var tCount = 0;
                if x > 0 {
                    if grid[x-1][y].mine {
                        tCount += 1;
                    }
                    grid[x][y].neighbors.append(grid[x-1][y])
                }
                if x < gridSize-1 {
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
                if y < gridSize-1 {
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
                if x > 0 && y < gridSize-1 {
                    if grid[x-1][y+1].mine {
                        tCount += 1;
                    }
                    grid[x][y].neighbors.append(grid[x-1][y+1])
                }
                if x < gridSize-1 && y > 0 {
                    if grid[x+1][y-1].mine {
                        tCount += 1;
                    }
                    grid[x][y].neighbors.append(grid[x+1][y-1])
                }
                if x < gridSize-1 && y < gridSize-1 {
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
        let touched = self.nodes(at: pos)
        for tile in touched {
            if tile.name == "Tile" {
                let cTile = tile as! Tile;
                cTile.change()
                if cTile.mine {
                    for row in grid {
                        for tile in row {
                            if tile.mine {
                                if flagMode == false {
                                     tile.change()
                                }
                            }
                        }
                    }
                }
            }
        }
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
