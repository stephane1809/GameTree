//
//  GameScene.swift
//  GameTree
//
//  Created by Vinícius Cavalcante on 29/03/23.
//

import Foundation
import SwiftUI
import SpriteKit
import GameKit

class GameScene: SKScene, ObservableObject {

    var gameModel = GameModel.shared
    var incrementGravity: Double = 0.0
    var lastTreeCreation: TimeInterval = .zero
    let gameCenter = ViewController()

    var realPaused: Bool = false {
        didSet {
            self.isPaused = realPaused
        }
    }

    override var isPaused: Bool {
        didSet {
            if self.isPaused == false && self.realPaused == true {
                self.isPaused = true
            }
        }
    }

    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        addLaserFloor()
    }

    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        if gameModel.isPaused == false && gameModel.isGameOver == false && currentTime - lastTreeCreation > 0.9 {
            createTree()
            incrementGravity += 0.01
            lastTreeCreation = currentTime
            physicsWorld.gravity = CGVector(dx: 0, dy: -0.3 - incrementGravity)
        }
    }

    static func makeFullscreenScene() -> GameScene {
        let scene = GameScene()
        scene.size = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        scene.scaleMode = .fill
        scene.backgroundColor = .white
        return scene
    }

    func createTree() {
            let treeSizes: [CGSize] = [CGSize(width: 30.5, height: 41.5), CGSize(width: 61, height: 83)]
            let treePositions: [CGPoint] = [CGPoint(x: 100, y: 900), CGPoint(x: 264, y: 900), CGPoint(x: 332, y: 900)]

            let tree = SKSpriteNode(imageNamed: "lofiTree")
            tree.name = "tree"
            tree.size = treeSizes.randomElement()!
            tree.position = treePositions.randomElement()!

            // physics property
            tree.physicsBody = SKPhysicsBody(rectangleOf: tree.frame.size)
            tree.physicsBody?.isDynamic = true
            tree.physicsBody!.affectedByGravity = true
            tree.physicsBody!.usesPreciseCollisionDetection = false
            tree.physicsBody?.contactTestBitMask = MascaraBit.Laser
            tree.physicsBody?.collisionBitMask = 0
            self.addChild(tree)
    }

    func addLaserFloor() {
        let laser = SKShapeNode()
        laser.position = CGPoint(x: self.size.width, y: 0)
        laser.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width*2, height: 1))
        laser.fillColor = .blue
        laser.physicsBody?.isDynamic = false
        laser.physicsBody?.contactTestBitMask = MascaraBit.Laser
        laser.physicsBody?.categoryBitMask = MascaraBit.Laser
        laser.physicsBody?.collisionBitMask = 0
        laser.name = "Laser"

        addChild(laser)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)

            if touchedNode.name == "tree" {
                gameModel.counterTree += 1
                if gameModel.counterTree > gameModel.record {
                    UserDefaults.standard.set(gameModel.counterTree, forKey: "tree")
                    gameCenter.saveGameCenterRecord(record: gameModel.counterTree)
//                    print(GKLeader)
                }
                touchedNode.removeFromParent()
            }
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Laser" || contact.bodyB.node?.name == "Laser" {
            gameModel.counterFall += 1
            if gameModel.counterFall == 1 {
                gameModel.lifesOverOne = true
            }
            if gameModel.counterFall == 2 {
                gameModel.lifesOverTwo = true
            }
            if gameModel.counterFall == 3 {
                gameModel.isGameOver = true
            }
        }
    }
}

struct MascaraBit {
    static let Laser: UInt32 = 2
}
