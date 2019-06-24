//
//  SharkComponent.swift
//  PlaygroundBook
//
//  Created by Mario Matheus on 18/03/19.
//

import GameplayKit


public enum WeightsMap: Float {
    case toWander = 0.8
    case followBySmell = 2.0
}


public class FishComponent: MoveComponent {
    
    var toUpdate = false
    var sharkBehavior: GKBehavior? {
        didSet {
            toUpdate = true
        }
    }
    
    
    override public init(maxSpeed: Float, maxAcceleration: Float, radius: Float) {
        super.init(maxSpeed: maxSpeed, maxAcceleration: maxAcceleration, radius: radius)
    }
    
    
    override public func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        if behavior == nil || toUpdate {
            toUpdate = false
            behavior = sharkBehavior == nil ?
                GKBehavior(goal: GKGoal(toWander: 100), weight: 0.7) :
                sharkBehavior!
        }
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
