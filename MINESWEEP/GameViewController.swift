//
//  GameViewController.swift
//  MINESWEEP
//
//  Created by Tyler Chan on 4/10/19.
//  Copyright © 2019 Tyler Chan. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var flagOutlet: UIButton!
    var gameScene : GameScene?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                gameScene = scene as! GameScene;
                gameScene?.flagOutlet = flagOutlet;
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    @IBAction func flagButton(_ sender: UIButton) {
        flagMode = !flagMode;
        if flagMode == false {
            flagOutlet?.setBackgroundImage(UIImage(named: "RedFlag"), for: .normal)
        } else if flagMode == true {
            flagOutlet?.setBackgroundImage(UIImage(named: "GreenFlag"), for: .normal)
        }
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        gameScene?.setup()
        gameScene?.mines = 0;
        gameScene?.Time?.invalidate()
        gameScene?.Time = nil;
        gameScene?.digit = 0;
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
