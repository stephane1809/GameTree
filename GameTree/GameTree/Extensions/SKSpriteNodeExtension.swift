//
//  SKSpriteNodeExtension.swift
//  GameTree
//
//  Created by Stephane Girão Linhares on 25/04/23.
//

import Foundation
import SpriteKit

extension SKScene {
    func getTextures(with name: String, textureAtlasName: String) -> [SKTexture] {
        let textureAtlas = SKTextureAtlas(named: textureAtlasName)
        var textures: [SKTexture] = []
        let names = textureAtlas.textureNames.sorted()
        for algo in 0..<names.count{
            if names[algo].contains(name) {
                let texture = textureAtlas.textureNamed(names[algo])
                texture.filteringMode = .nearest
                textures.append(texture)
            }
        }
        return textures
    }
}
