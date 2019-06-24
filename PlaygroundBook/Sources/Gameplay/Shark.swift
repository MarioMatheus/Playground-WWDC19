//
//  Shark.swift
//  PlaygroundBook
//
//  Created by Mario Matheus on 18/03/19.
//

import GameplayKit

public class Shark: Fish {
    
    var sightRange: CGFloat = 30 // 2m...3m normal, usada ate 30m
    var smellRange: CGFloat = 300 // até 300m
    var hearingRange: CGFloat = 250 // 250m...1500m
    
    var maxSpeed: Float = 50
    var maxAccelation: Float = 10
    var radius: Float = 10
    
    var sight: SKShapeNode?
    var sightLight: SKLightNode?
    
    var hearing: SKShapeNode?
    var smell: SKShapeNode?
    var soughtFishes: [Fish] = [] {
        didSet {
            var weightCount = 1
            var goals: [GKGoal] = []
            var weights: [NSNumber] = []
            soughtFishes.forEach({ fish in
                goals.append(GKGoal(toSeekAgent: fish.component(ofType: FishComponent.self)!))
                weights.append(NSNumber(integerLiteral: weightCount * goals.count * 100 ))
                weightCount += 1
            })
            let fishSwimming = GKGoal(toWander: 100)
            goals.append(fishSwimming)
            weights.append(0.7)
            let behavior = GKBehavior(goals: goals, andWeights: weights)
            component(ofType: FishComponent.self)?.sharkBehavior = behavior
        }
    }
    
    
    public init() {
        super.init(spriteNamed: "tubarao_nadando_1", maxSpeed: maxSpeed, maxAccelation: maxAccelation, radius: radius)
        component(ofType: FishComponent.self)?.canMove = false
        component(ofType: VisualComponent.self)?.sprite.name = "Shark"
    }
    
    
    public func addSight(radius: CGFloat) {
        if let sprite = component(ofType: VisualComponent.self)?.sprite {
            let shape = SKShapeNode(circleOfRadius: radius)
            shape.fillColor = .clear // .cyan
            // shape.fillColor = shape.fillColor.withAlphaComponent(0.1)
            shape.strokeColor = .cyan // shape.fillColor
            shape.position.x = sprite.size.width/2 - 5
            
            // let sightSprite = SKSpriteNode(texture: SKView().texture(from: shape))
            let physicBody = SKPhysicsBody(circleOfRadius: radius)
            physicBody.collisionBitMask = 0
            physicBody.contactTestBitMask = 1
            
            sprite.zPosition = 10
            shape.zPosition = 9
            
            shape.name = "SharkSight"
            shape.physicsBody = physicBody
            // sightSprite.shadowCastBitMask = 0b0001
            // sightSprite.lightingBitMask = 0b0001
            self.sight = shape
            sprite.addChild(shape)
        }
    }
    
    
    public func addSmell(radius: CGFloat) {
        if let sprite = component(ofType: VisualComponent.self)?.sprite {
            let shape = SKShapeNode(circleOfRadius: radius)
            shape.fillColor = .clear //.green
            // shape.fillColor = shape.fillColor.withAlphaComponent(0.5)
            shape.strokeColor = .green
            shape.position.x = sprite.size.width/2 - 5
            
            let physicBody = SKPhysicsBody(circleOfRadius: radius)
            physicBody.collisionBitMask = 0
            physicBody.contactTestBitMask = 1
            
            shape.name = "SharkSmell"
            shape.physicsBody = physicBody
            sprite.zPosition = 10
            shape.zPosition = 8
            self.smell = shape
            
            sprite.addChild(shape)
        }
    }
    
    
    public func addHearing(radius: CGFloat) {
        if let sprite = component(ofType: VisualComponent.self)?.sprite {
            let shape = SKShapeNode(circleOfRadius: radius)
            shape.fillColor = .clear// .yellow
//            shape.fillColor = shape.fillColor.withAlphaComponent(0.05)
            shape.strokeColor = .yellow
            shape.position.x = sprite.size.width/2 - 5
            
            let physicBody = SKPhysicsBody(circleOfRadius: radius)
            physicBody.collisionBitMask = 0
            physicBody.contactTestBitMask = 1
            
            shape.name = "SharkHearing"
            shape.physicsBody = physicBody
            sprite.zPosition = 10
            shape.zPosition = 7
            self.hearing = shape
            
            sprite.addChild(shape)
        }
    }
    
    
    public func addLightToSight(ambientColor: UIColor, lightColor: UIColor) {
        if let sprite = component(ofType: VisualComponent.self)?.sprite, let _ = sight {
            let light = SKLightNode()
            light.name = "SightLight"
            light.position = .zero
            light.falloff = 1.1
            light.ambientColor = ambientColor
            light.lightColor = lightColor
            light.categoryBitMask = 0b0001
            
            sightLight = light
            sprite.addChild(light)
        }
    }
    
    public func removeLightFromSight() {
        sightLight?.removeFromParent()
    }
    
    
    public func startToSwim() {
        component(ofType: FishComponent.self)?.canMove = true
        component(ofType: VisualComponent.self)?.startLoopAnimation(character: "tubarao", action: "nadando", spritesCount: 7)
    }
    
    
    public func startPowerfulRadar() {
        if let sprite = component(ofType: VisualComponent.self)?.sprite {
            sprite.run(SKAction.repeatForever(SKAction.sequence([
                SKAction.wait(forDuration: 5),
                SKAction.run {
                    let sonar = SKSpriteNode(imageNamed: "sonar")
                    sonar.name = "SharkRadar"
                    sonar.setScale(0.1)
                    sonar.physicsBody = SKPhysicsBody(circleOfRadius: sonar.size.width/2)
                    sonar.physicsBody?.collisionBitMask = 0
                    sprite.addChild(sonar)
                    sonar.run(SKAction.scale(by: 10, duration: 2), completion: {
                        sonar.removeFromParent()
                    })
                }
            ])))
            
        }
    }
    
    
    public func startToFollow(fish: Fish) {
        if soughtFishes.contains(fish) == false {
            fish.isBeingFollowed = true
            soughtFishes.append(fish)
        }
    }
    
    
    public func stopToFollow(fish: Fish) {
        fish.isBeingFollowed = false
        fish.stoppedEmaneting = false
        soughtFishes.removeAll(where: { $0 === fish })
    }
    
    
    public func move(to position: CGPoint, completion: (()->Void)? = nil) {
        if let visualComponent = component(ofType: VisualComponent.self), let fishComponent = component(ofType: FishComponent.self), fishComponent.canMove {
            let sprite = visualComponent.sprite
            let distance = sqrt(pow(sprite.position.y - position.y, 2) + pow(sprite.position.x - position.x, 2))
            let velocity = distance / CGFloat(fishComponent.maxSpeed)
            fishComponent.lastMoveLocation = position
            
            let moveAction = SKAction.move(to: position, duration: TimeInterval(velocity))
            sprite.removeAction(forKey: "MoveToTouchPosition")
            // sprite.removeAllActions()
            sprite.run(SKAction.sequence([moveAction, SKAction.run{ completion?() } ]), withKey: "MoveToTouchPosition")
        }
    }
    
    
    public func eat(fish: Fish, afterSnack: @escaping ()->Void) {
        if let visualComponent = component(ofType: VisualComponent.self) {
            visualComponent.startLoopAnimation(character: "tubarao", action: "lanchando", spritesCount: 4)
            move(to: fish.component(ofType: VisualComponent.self)!.sprite.position, completion: {
                visualComponent.startLoopAnimation(character: "tubarao", action: "nadando", spritesCount: 7)
                afterSnack()
                self.stopToFollow(fish: fish)
            })
        }
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
