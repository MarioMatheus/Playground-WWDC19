//
//  EntityManager.swift
//  Book_Sources
//
//  Created by Mario Matheus on 18/03/19.
//

import GameplayKit

public final class EntityManager {
    
    private let scene: SKScene
    private var entities: Set<GKEntity>
    
    var toRemove = Set<GKEntity>()
    lazy var componentSystems: [GKComponentSystem] = {
        let sharkComponent = GKComponentSystem(componentClass: FishComponent.self)
        return [sharkComponent]
    }()
    
    
    init(scene: SKScene) {
        self.scene = scene
        entities = Set<GKEntity>()
    }
    
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }
    
    
    func add(_ entities: [GKEntity]) {
        entities.forEach { [weak self] entity in
            self?.add(entity)
        }
    }
    
    
    func remove(_ entity: GKEntity) {
        guard let sprite = entity.component(ofType: VisualComponent.self)?.sprite else {
            return
        }
        
        sprite.removeFromParent()
        
        entities.remove(entity)
        toRemove.insert(entity)
    }
    
    
    func update(_ deltaTime: CFTimeInterval) {
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }
        
        for entity in entities {
            entity.update(deltaTime: deltaTime)
        }
        
        for currentRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: currentRemove)
            }
        }
        toRemove.removeAll()
    }
    
    
    func getComponents<T: GKComponent>(type: T.Type) -> [T] {
        var components = [T]()
        for entity in entities {
            if let component = entity.component(ofType: T.self) {
                components.append(component)
            }
        }
        return components
    }
    
}
