//
//  VisualComponent.swift
//  Book_Sources
//
//  Created by Mario Matheus on 18/03/19.
//

import GameplayKit


public class VisualComponent: GKComponent {
    
    var sprite: SKSpriteNode
    
    
    public init(spriteNamed: String) {
        sprite = SKSpriteNode(imageNamed: spriteNamed)
        super.init()
    }
    
    
    public func createTextureFrames(_ textureName: String, textureCount: Int) -> [SKTexture] {
        var frames = [SKTexture]()
        for i in 1...textureCount {
            let characterTextureName = "\(textureName)_\(i)"
            frames.append(SKTexture(imageNamed: characterTextureName))
        }
        return frames
    }
    
    
    public func startLoopAnimation(character: String, action: String, spritesCount: Int) {
        // let key = "\(character)_\(action)Animation"
        let key = "Animation"
        sprite.removeAction(forKey: key)
        
        let animationFrames = createTextureFrames("\(character)_\(action)", textureCount: spritesCount)
        sprite.run(SKAction.repeatForever(
            SKAction.animate(with: animationFrames, timePerFrame: 0.2, resize: false, restore: true)
        ), withKey: key)
    }
    
    
    public func startSimpleAnimation(character: String, action: String, spritesCount: Int, completion: @escaping ()->Void) {
        let key = "\(character)_\(action)Animation"
        sprite.removeAction(forKey: key)
        let animationThrowWeaponFrames = createTextureFrames("\(character)_\(action)", textureCount: spritesCount)
        sprite.run(
            SKAction.animate(with: animationThrowWeaponFrames, timePerFrame: 0.2, resize: false, restore: true),
            completion: { completion() })
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
