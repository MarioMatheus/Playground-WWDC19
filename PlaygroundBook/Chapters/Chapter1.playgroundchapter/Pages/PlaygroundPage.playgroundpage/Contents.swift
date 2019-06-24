//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, addSwimmingBehavior())


import PlaygroundSupport
func addSwimmingBehavior() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("SwimmingBehavior")
        proxy.send(message)
    }
}

//#-end-hidden-code


//: ## Get Started
//: Welcome to the shark breeder, in this manual we will build the main senses and behaviors
//: of the greatest predators of the seas.
//:
//: ###
//: - Important:
//: Sharks are at the top of the food chain in the underwater kingdom, they have several species of
//: the most varied forms, the best known being the white shark, the tiger shark, the mako shark and
//: the hammerhead shark. They breathe through gill slits and have placoid scales that protect them
//: from damage and improve their hydrodynamics.
//:
//: ###
//: ## Manual
//: In this manual we will create our shark by adding its senses and behaviors.
//: * Swim
//: * View
//: * Smell
//: * Hearing
//:
//: - Note:
//: For a better experience, use iPad in Landscape
//:
//: ###
//: ## Starting with the swim (not synchronized)
//: Some species of sharks spend their lives scouring the ocean for food, others lead a more sedentary life,
//: waiting for the food to appear on its own. Beside you should see a Thresher Shark floating (be quiet, he is not dead).
//: We need to add his Swim, in this case, we will make our shark wander around looking for food,
//: after all it would be very dull to see him stopped.
//:
//: ###
//: **Come on! TAP below, select `addSwimmingBehavior()` and run your code.**
//#-editable-code Tap to enter code
//#-end-editable-code
//:
//: - Note:
//: You can tap the screen to move the shark

//: [Next: Sight beyond range or not](@next)
