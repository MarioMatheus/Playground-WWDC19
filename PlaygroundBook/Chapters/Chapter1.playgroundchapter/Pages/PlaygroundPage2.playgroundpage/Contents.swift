//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, addSmallSightToShark(), addSightRepresentationByLight(), removeSightRepresentationByLight())



import PlaygroundSupport
func addSmallSightToShark() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("AddSmallSightToShark")
        proxy.send(message)
    }
}

func addSightRepresentationByLight() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("AddSightRepresentationByLight")
        proxy.send(message)
    }
}

func removeSightRepresentationByLight() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("RemoveSightRepresentationByLight")
        proxy.send(message)
    }
}


//#-end-hidden-code


//: ## The Shark's Sight
//: Your shark is now wandering the ocean but can not find your food, I think the fish are happy about it.
//: It turns out that the shark is not seeing anything to attack, I think if we add your vision,
//: the fish will not be happy.
//:
//: ###
//: - Important:
//: Some scientists believe that sharks are myopic, with good sight of up to 3 meters,
//: and can reach up to 30 meters with less definition. Others believe that the shark's lens is usually
//: fixed for viewing at a distance, adjusting to the approach of objects. One thing is certain,
//: your eyes are on the sides of the head, soon your vision reaches almost 360°.
//:
//: ###
//: ## Adding sight
//: His Thresher Shark is hungry, he's looking for food but without vision it's hard to see his snack.
//: Let's add a small field of sight for your shark look for food and kill who is killing him, the hunger.
//:
//: ###
//: **Come on! TAP below and select `addSmallSightToShark()` and run your code.**
//#-editable-code Tap to enter code
//#-end-editable-code
//:
//: - Note:
//: The sight is represented by a blue border circle, if a fish enters the circle,
//: that is, in the field of sight, the shark will feed on the fish.
//: You can call the methods `addSightRepresentationByLight` and `removeSightRepresentationByLight`
//: to see the shark's sight simulations.
//:

//: [Next: A Good Smell](@next)
