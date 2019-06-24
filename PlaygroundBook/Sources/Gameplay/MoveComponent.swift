//
//  MoveComponent.swift
//  Book_Sources
//
//  Created by Mario Matheus on 18/03/19.
//
import GameplayKit


public class MoveComponent: GKAgent2D, GKAgentDelegate {
    
    var lastVelocity: vector_float2!
    var lastMoveLocation: CGPoint!
    var canMove = true
    
    public init(maxSpeed: Float, maxAcceleration: Float, radius: Float) {
        super.init()
        delegate = self
        self.maxSpeed = maxSpeed
        self.maxAcceleration = maxAcceleration
        self.radius = radius
        self.mass = 0.01
    }
    
    
    public func agentWillUpdate(_ agent: GKAgent) {
        if canMove == false { return }
        guard let spriteNode = entity?.component(ofType: VisualComponent.self)?.sprite else {
            fatalError("Agent has no VisualComponent.")
        }
        self.position = vector_float2(x: Float(spriteNode.position.x), y: Float(spriteNode.position.y))
    }
    
    
    public func agentDidUpdate(_ agent: GKAgent) {
        if canMove == false { return }
        guard let spriteNode = entity?.component(ofType: VisualComponent.self)?.sprite else {
            fatalError("Agent has no VisualComponent.")
        }
        if let last = lastVelocity, (last.x > 0 && velocity.x < 0) || (last.x < 0 && velocity.x > 0) {
            spriteNode.yScale *= (velocity.x < 0 ? 1 : -1) * -1
        }
        lastVelocity = velocity
        
        var angle: CGFloat = 0
        if spriteNode.action(forKey: "MoveToTouchPosition") != nil {
            angle = CGFloat(atan2(lastMoveLocation.y - spriteNode.position.y, lastMoveLocation.x - spriteNode.position.x))
        } else {
            angle = CGFloat(atan2(velocity.y, velocity.x))
        }
        
        spriteNode.zRotation = angle
        spriteNode.position = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
    }
    
    
    override public func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
}
