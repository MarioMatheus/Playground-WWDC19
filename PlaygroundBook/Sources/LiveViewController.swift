//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  An auxiliary source file which is part of the book-level auxiliary sources.
//  Provides the implementation of the "always-on" live view.
//

import UIKit
import SpriteKit
import PlaygroundSupport

@objc(Book_Sources_LiveViewController)
public class LiveViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    var currentPage = 4
    var scene: SKScene?
    /*
    public func liveViewMessageConnectionOpened() {
        // Implement this method to be notified when the live view message connection is opened.
        // The connection will be opened when the process running Contents.swift starts running and listening for messages.
    }
    */

    /*
    public func liveViewMessageConnectionClosed() {
        // Implement this method to be notified when the live view message connection is closed.
        // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
        // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
    }
    */

    public func receive(_ message: PlaygroundValue) {
        guard case let .string(function) = message else { return }
        
        switch function {
        case "SwimmingBehavior":
            (scene as? TestScene)?.addMovementToShark()
        case "AddSmallSightToShark":
            (scene as? TestScene)?.addSmallSightToShark()
        case "AddMediumSightToShark":
            (scene as? TestScene)?.addMediumSightToShark()
        case "AddLargeSightToShark":
            (scene as? TestScene)?.addLargeSightToShark()
        case "AddSightRepresentationByLight":
            (scene as? TestScene)?.addLightToSight()
        case "RemoveSightRepresentationByLight":
            (scene as? TestScene)?.removeLightFromSight()
        case "AddSmallSmellToShark":
            (scene as? TestScene)?.addSmallSmellToShark()
        case "AddMediumSmellToShark":
            (scene as? TestScene)?.addMediumSmellToShark()
        case "AddLargeSmellToShark":
            (scene as? TestScene)?.addLargeSmellToShark()
        case "AddSmallHearingToShark":
            (scene as? TestScene)?.addSmallHearingToShark()
        case "AddMediumHearingToShark":
            (scene as? TestScene)?.addMediumHearingToShark()
        case "AddLargeHearingToShark":
            (scene as? TestScene)?.addLargeHearingToShark()
        default:
            break
        }
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
    }
    
    public override func viewDidLoad() {
        view = SKView(frame: view.frame)
        if let view = view as? SKView {
            let scene = TestScene(size: view.frame.size)
            scene.scaleMode = .aspectFill
            self.scene = scene
            configureScene()
            view.presentScene(scene)
        }
    }
    
    
    func configureScene() {
        switch currentPage {
        case 2:
            (scene as? TestScene)?.addMovementToShark()
        case 3:
            (scene as? TestScene)?.addMovementToShark()
            (scene as? TestScene)?.addSmallSightToShark()
        case 4:
            (scene as? TestScene)?.addMovementToShark()
            (scene as? TestScene)?.addSmallSightToShark()
            (scene as? TestScene)?.addMediumSmellToShark()
        case 5:
            break
        case 6:
            (scene as? TestScene)?.addMovementToShark()
            (scene as? TestScene)?.addSmallSightToShark()
            (scene as? TestScene)?.addMediumSmellToShark()
            (scene as? TestScene)?.addMediumHearingToShark()
            (scene as? TestScene)?.addMe()
            
        default:
            break
        }
    }

    
    public override func viewDidLayoutSubviews() {
        if let view = view as? SKView {
            if let scene = view.scene as? TestScene {
                scene.layoutSubviews(size: view.frame.size)
            }
        }
    }
}
