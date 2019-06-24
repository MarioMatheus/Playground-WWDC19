//
//  TestScene.swift
//  Book_Sources
//
//  Created by Mario Matheus on 18/03/19.
//

import SpriteKit
import Foundation


public class TestScene: SKScene {
    
    var delta: TimeInterval = 0
    var lastUpdateTime: TimeInterval = 0
    var entityManager: EntityManager!
    
    var oceanCamera = SKCameraNode()
    
    var shark: Shark
    var fishes: [Fish] = []
    var oceanSprite: SKSpriteNode!
    
    var originalSceneOrientation: String?
    var currentOrientation: String?
    var isToMoveInLandscape = false
    
    
    override public init(size: CGSize) {
        shark = Shark()
        super.init(size: size)
        entityManager = EntityManager(scene: self)
        
        physicsWorld.gravity = .zero
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.contactDelegate = self
        
        oceanSprite = SKSpriteNode(imageNamed: "ocean")
        
        oceanSprite.position = .zero
        addChild(oceanSprite)
        
        
        oceanCamera.position = oceanSprite.position
        camera = oceanCamera
        addChild(oceanCamera)
        
        if let sprite = shark.component(ofType: VisualComponent.self)?.sprite {
            sprite.position = .zero
            sprite.size.width /= 2
            sprite.size.height /= 2
            addChild(sprite)
        }
        entityManager.add(shark)
    }
    
    override public func didMove(to view: SKView) {
        for _ in 0...5 {
            spawnFish()
        }
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.wait(forDuration: 10),
            SKAction.run({
                if self.fishes.count < 5 {
                    self.spawnFish()
                }
            })
        ])))
        children.filter({ $0 is SKSpriteNode }).forEach({
            ($0 as? SKSpriteNode)?.lightingBitMask = 0b0001
        })
    }
    
    
    func spawnFish() {
        let value = Int.random(in: 0...2)
        let spriteName = Fishes(rawValue: value)!.spriteName
        let fish = Fish(spriteNamed: "\(spriteName)_nadando_1")
        if let visualComponent = fish.component(ofType: VisualComponent.self) {
            let sprite = visualComponent.sprite
            sprite.position = CGPoint(x: CGFloat.random(in: oceanSprite.frame.minX...oceanSprite.frame.maxX),
                                      y: CGFloat.random(in: oceanSprite.frame.minY...oceanSprite.frame.maxY))
            sprite.size.width /= 2
            sprite.size.height /= 2
            addChild(sprite)
            visualComponent.startLoopAnimation(character: spriteName, action: "nadando", spritesCount: 5)
            fish.createSmellAction()
            fish.createHearingAction()
            fishes.append(fish)
            entityManager.add(fish)
        }
        
    }
    
    
    public func addMe() {
        if let shark = shark.component(ofType: VisualComponent.self)?.sprite {
            let me = SKSpriteNode(imageNamed: "me_2")
            me.size = CGSize(width: 32, height: 32)
            me.position = CGPoint(x: 10, y: 0)
            shark.addChild(me)
        }
    }
    
    
    public func addMovementToShark() {
        shark.startToSwim()
    }
    
    public func addSmallSightToShark() {
        shark.addSight(radius: 20)
    }
    
    
    public func addMediumSightToShark() {
        shark.addSight(radius: 40)
    }
    
    
    public func addLargeSightToShark() {
        shark.addSight(radius: 40)
    }
    
    
    public func addLightToSight() {
        let color = UIColor(red: 67/255, green: 109/255, blue: 140/255, alpha: 1)
        shark.addLightToSight(ambientColor: color, lightColor: color)
    }
    
    
    public func addSmallSmellToShark() {
        shark.addSmell(radius: 60)
    }
    
    
    public func addMediumSmellToShark() {
        shark.addSmell(radius: 90)
    }
    
    public func addLargeSmellToShark() {
        shark.addSmell(radius: 120)
    }
    
    
    public func addSmallHearingToShark() {
        shark.addHearing(radius: 100)
    }
    
    
    public func addMediumHearingToShark() {
        shark.addHearing(radius: 150)
    }
    
    
    public func addLargeHearingToShark() {
        shark.addHearing(radius: 180)
    }
    
    
    public func removeLightFromSight() {
        shark.removeLightFromSight()
    }
    
    
    override public func update(_ currentTime: TimeInterval) {
        delta = lastUpdateTime > 0 ? currentTime - lastUpdateTime : 0
        lastUpdateTime = currentTime
        entityManager.update(delta)
        children.forEach { node in
            let position = node.position
            if !(oceanSprite.frame.minX...oceanSprite.frame.maxX).contains(position.x) {
                node.position.x = node.position.x < 0 ? oceanSprite.frame.maxX : oceanSprite.frame.minX
                if node.name == "Shark" && isToMoveInLandscape {
                    oceanCamera.position.x = (node.position.x < 0) ?
                        oceanSprite.frame.maxX - size.width/5 :
                        oceanSprite.frame.minX + size.width/5
                }
            } else if !(oceanSprite.frame.minY...oceanSprite.frame.maxY).contains(position.y) {
                node.position.y = node.position.y < 0 ? oceanSprite.frame.maxY : oceanSprite.frame.minY
                if node.name == "Shark" && currentOrientation == "portrait" {
                    oceanCamera.position.y = (node.position.y < 0) ?
                        oceanSprite.frame.maxY - size.height/4 :
                        oceanSprite.frame.minY + size.height/4
                }
            }
            
            fishes.filter({ $0.stoppedEmaneting }).forEach({ shark.stopToFollow(fish: $0) })
            
            fishes.filter({ ($0.emanatingSmell || $0.isMakingNoise) && $0.isBeingFollowed == false }).forEach({ fish in
                if let sprite = fish.component(ofType: VisualComponent.self)?.sprite {
                    if fish.emanatingSmell && shark.smell?.physicsBody?.allContactedBodies()
                        .filter({ $0 === sprite.physicsBody }).count ?? 0 > 0 {
                        shark.startToFollow(fish: fish)
                    }
                    if fish.isMakingNoise && shark.hearing?.physicsBody?.allContactedBodies()
                        .filter({ $0 === sprite.physicsBody }).count ?? 0 > 0 {
                        shark.startToFollow(fish: fish)
                    }
                }
            })
            if currentOrientation != nil { moveCamera() }
        }
        
    }
    
    public func moveCamera() {
        if currentOrientation == "portrait" {
            if let sharkSprite = shark.component(ofType: VisualComponent.self)?.sprite {
                var range: ClosedRange<CGFloat>
                if originalSceneOrientation == "landscape" {
                    range = (oceanSprite.frame.maxX - size.height/5)...(oceanSprite.frame.minX + size.height/5)
                } else {
                    range = (oceanSprite.frame.maxY - size.height/4)...(oceanSprite.frame.minY + size.height/4)
                }
                if range.contains(sharkSprite.position.y) {
                    oceanCamera.position.y = sharkSprite.position.y
                }
            }
        } else {
            if isToMoveInLandscape {
                if let sharkSprite = shark.component(ofType: VisualComponent.self)?.sprite {
                    let range = (oceanSprite.frame.maxX - size.width/5)...(oceanSprite.frame.minX + size.width/5)
                    if range.contains(sharkSprite.position.x) {
                        oceanCamera.position.x = sharkSprite.position.x
                    }
                }
            } else {
                oceanCamera.position = oceanSprite.position
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let position = touches.first?.location(in: self) {
            shark.move(to: position)
        }
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // I apologize for this method
    func layoutSubviews(size: CGSize) {
        originalSceneOrientation = (self.size.width > self.size.height) ? "landscape" : "portrait"
        currentOrientation = (size.width > size.height) ? "portrait" : "landscape"
        let widthScale = size.width / (oceanSprite.size.width)
        var divisor: CGFloat = self.size.width > self.size.height ? 3 : 4.5
        if divisor == 3 {
            divisor = (size.width > size.height) ? 4.5 : 3
        } else {
            divisor = (size.width > size.height) ? 3.3 : 4
        }
        let scale = widthScale / divisor
        var fator: CGFloat = 0.9
        
        if size.width < size.height {
            if size.width > 682 { fator = 0.5 }
            else if size.width > 596 { fator = 0.65 }
            else if size.width > 555 { fator = 0.75 } // 0.8
        } else {
            if size.width > 1023 { fator = 0.5 } // 1024
            else if size.width > 833 { fator = 0.4 } //834
            else if size.width > 767 { fator = 0.5 } // 0.8
        }
        isToMoveInLandscape = false
        if size.width < size.height && size.width < 513 && min(self.size.width, self.size.height) > 768 {
            fator = 0.65
            isToMoveInLandscape = true
        }
        
        oceanCamera.setScale(scale * fator)
    }
    
}


extension TestScene: SKPhysicsContactDelegate {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if contact.isCollisionBettween("SharkSight", and: "Fish") {
            fishes.forEach({ fish in
                if let sprite = fish.component(ofType: VisualComponent.self)?.sprite {
                    if contact.bodyA.node === sprite || contact.bodyB.node === sprite {
                        shark.eat(fish: fish, afterSnack: {
                            self.fishes.removeAll(where: { $0 === fish })
                            self.entityManager.remove(fish)
                        })
                    }
                }
            })            
        }
    }
    
    
    public func didEnd(_ contact: SKPhysicsContact) {
        if contact.isCollisionBettween("SharkSmell", and: "Fish") || contact.isCollisionBettween("SharkHearing", and: "Fish")  {
            if let fishe = fishes.filter({ fish in
                let sprite = fish.component(ofType: VisualComponent.self)?.sprite
                return contact.bodyA.node === sprite || contact.bodyB.node === sprite
            }).first {
                shark.stopToFollow(fish: fishe)
            }
        }
    }
    
}


extension SKPhysicsContact {
    
    public func isCollisionBettween(_ nodeNameA: String, and nodeNameB: String) -> Bool {
        var isContact = false
        if let nameA = self.bodyA.node?.name, let nameB = self.bodyB.node?.name {
            isContact = (nameA == nodeNameA || nameA == nodeNameB) &&
                (nameB == nodeNameA || nameB == nodeNameB)
            if nodeNameA != nodeNameB {
                isContact = isContact && nameA != nameB
            }
        }
        return isContact
    }

}
