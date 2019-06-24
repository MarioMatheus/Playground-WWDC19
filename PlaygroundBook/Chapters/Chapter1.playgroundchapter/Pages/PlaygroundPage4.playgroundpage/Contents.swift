//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, addSightRepresentationByLight(), removeSightRepresentationByLight())
//#-code-completion(identifier, show, addMediumHearingToShark())


import PlaygroundSupport

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

func addMediumHearingToShark() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("AddMediumHearingToShark")
        proxy.send(message)
    }
}


//#-end-hidden-code


//: ## The Hearing
//: The shark is already managing to eat better. If he is still having difficulty feeding,
//: he has a more powerful sense, that is, the strength of a shark goes well beyond what
//: has already been presented, this time we will approach his hearing.
//:
//: ###
//: - Important:
//: Sharks have small holes at the top of the head, connected to semicircular inner canals
//: that accurately detect underwater sounds like a fish cracking up to 1500m away.
//:
//: ###
//: ## Adding Hearing
//: Your hearing as well as your sense of smell is one of the main senses used by sharks to search for food,
//: with which your shark can hear the fish that are making noise.
//:
//: ###
//: **Come on! TAP below and select `addMediumHearingToShark()` and run your code.**
//#-editable-code Tap to enter code
//#-end-editable-code
//:
//: - Note:
//: The hearing is represented by a yellow border circle, if a fish is playing a French Horn and
//: enters the hearing field of shark, this will follow the noise to stop the sound and will take
//: the opportunity to snack.
//:
//: [Next: Building](@next)
