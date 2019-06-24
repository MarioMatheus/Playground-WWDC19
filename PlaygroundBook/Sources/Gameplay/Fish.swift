//
//  Fish.swift
//  LiveViewTestApp
//
//  Created by Mario Matheus on 19/03/19.
//

import GameplayKit


public class Fish: GKEntity {
    
    var isBeingFollowed = false
    
    var emanatingSmell = false
    var stoppedEmaneting = false
    
    var isMakingNoise = false
    
    public init(spriteNamed: String, maxSpeed: Float = 20, maxAccelation: Float = 6, radius: Float = 10) {
        super.init()
        addComponent(VisualComponent(spriteNamed: spriteNamed))
        addComponent(FishComponent(maxSpeed: maxSpeed, maxAcceleration: maxAccelation, radius: radius))
        addPhysic()
    }
    
    
    public func addPhysic() {
        if let sprite = component(ofType: VisualComponent.self)?.sprite {
            let physic = SKPhysicsBody(circleOfRadius: sprite.size.height/12)
            physic.collisionBitMask = 0
            physic.contactTestBitMask = 1
            sprite.physicsBody = physic
            sprite.name = "Fish"
        }
    }
    
    
    func createSmellAction() {
        if let sprite = component(ofType: VisualComponent.self)?.sprite {
            sprite.run(SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.wait(forDuration: TimeInterval(Int.random(in: 8...16))),
                    mainSmellAction(in: sprite)
                ]))
            )
        }
    }
    
    
    func mainSmellAction(in sprite: SKSpriteNode) -> SKAction {
        return SKAction.run({
            if Bool.random() {
                if self.isMakingNoise == true { return }
                self.emanatingSmell = !self.emanatingSmell
                // muda sprite
                if self.emanatingSmell {
//                    let s = SKShapeNode(circleOfRadius: 5)
//                    s.name = "sTeste"
//                    s.fillColor = .green
//                    sprite.addChild(s)
                    let s = SKSpriteNode(imageNamed: "pseudo_odor")
                    s.name = "PseudoOdor"
                    s.position.y = 5
                    sprite.addChild(s)
                    s.run(SKAction.repeatForever(SKAction.sequence([
                        SKAction.moveBy(x: 0, y: 5, duration: 0.5),
                        SKAction.moveBy(x: 0, y: -5, duration: 0.5),
                        ])))
                } else {
                    self.stoppedEmaneting = true
                    sprite.childNode(withName: "PseudoOdor")?.removeFromParent()
                }
            }
        })
    }
    
    
    func createHearingAction() {
        if let sprite = component(ofType: VisualComponent.self)?.sprite {
            sprite.run(SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.wait(forDuration: TimeInterval(Int.random(in: 5...20))),
                    mainHearingAction(in: sprite)
                ]))
            )
        }
    }
    
    
    func mainHearingAction(in sprite: SKSpriteNode) -> SKAction {
        return SKAction.run({
            if Bool.random() {
                if self.emanatingSmell == true { return }
                self.isMakingNoise = !self.isMakingNoise
                // muda sprite
                if self.isMakingNoise {
//                    let s = SKShapeNode(circleOfRadius: 5)
//                    s.name = "hTeste"
//                    s.fillColor = .yellow
//                    sprite.addChild(s)
                    let s = SKSpriteNode(imageNamed: "trompa_1")
                    s.name = "Trompa"
                    s.zRotation = .pi/4
                    s.size.width *= 0.75
                    s.size.height *= 0.75
                    s.position.x = 15
                    sprite.addChild(s)
                    let textures = [1,2,3,4,5].map({ n -> SKTexture in
                        return SKTexture(imageNamed: "trompa_\(n)")
                    })
                    let animation = SKAction.animate(with: textures, timePerFrame: 0.2,
                                                     resize: false, restore: true)
                    s.run(SKAction.repeatForever(animation))
                } else {
                    sprite.childNode(withName: "Trompa")?.removeFromParent()
                }
            }
        })
    }
    
    
    // public func startBeep(in sprite: SKSpriteNode) {
    //
    // }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



public enum Fishes: Int {
    case azul = 0, palhaco, carpa
    
    public var spriteName: String {
        switch self.rawValue {
        case 0:
            return "azul"
        case 1:
            return "palhaco"
        case 2:
            return "carpa"
        default:
            return""
        }
    }
}
