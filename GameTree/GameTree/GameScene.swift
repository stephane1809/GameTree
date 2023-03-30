//
//  GameScene.swift
//  GameTree
//
//  Created by Vinícius Cavalcante on 29/03/23.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    var counterTree: Int = 0
    var counterFall: Int = 0
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        addLaserFloor()

        Task {
            while true {
                try? await Task.sleep(for: .seconds(0.5))
                createTree()
            }
        }
    }

    func createTree() {
        let treeSizes: [CGSize] = [CGSize(width: 30.5, height: 41.5), CGSize(width: 61, height: 83)]
        let treePositions: [CGPoint] = [CGPoint(x: 100, y: 900), CGPoint(x: 264, y: 1400), CGPoint(x: 332, y: 1100)]

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
        // Animations
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

    func deleteTree() {

    }

    func gameOver() {

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)

            if touchedNode.name == "tree" {
                counterTree += 1
                print("Arvores tocadas: \(counterTree)")
                touchedNode.removeFromParent()
            }
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Laser" || contact.bodyB.node?.name == "Laser" {
            counterFall += 1
            if counterFall >= 3 {
                print("vc perdeu")
            }
        }
    }
}

struct MascaraBit {
    static let Laser: UInt32 = 2
}
