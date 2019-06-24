//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, addSightRepresentationByLight(), removeSightRepresentationByLight())
//#-code-completion(identifier, show, addMediumSmellToShark())


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

func addMediumSmellToShark() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("AddMediumSmellToShark")
        proxy.send(message)
    }
}


//#-end-hidden-code


//: ## The Shark Olfaction
//: The shark is already managing to feed himself (or not), with his sight he can snack on the
//: fish he sees in the ocean. But at times, it can be very difficult to find a fish with its poor sight.
//: How about now, give the olfaction to shark.
//:
//: ###
//: - Important:
//: The shark's nose is very powerful, with the sense that it has the power to detect scents of blood
//: or decomposing bodies from a distance of up to 300 meters.
//: The hammerhead shark has a sharper smell for its shape and spaces between the nostrils is larger.
//:
//: ###
//: ## Adding olfaction
//: With your nose, your Thresher Shark can smell fish (if they are hurt or smelling really strong),
//: then the shark can investigate the smell of food.
//:
//: ###
//: **Come on! Take a TAP below and select `addMediumSmellToShark()` and run your code.**
//#-editable-code Tap to enter code
//#-end-editable-code
//:
//: - Note:
//: The olfaction is represented by a green border circle, if a fish with a strong smell enters the circle,
//: the shark will investigate the odour and consequently will find the fish. The fish odour is represented
//: by three green gases on the fish.
//: You can call the `turnOffRangeRepresentation` method to hide the sensing reaches and
//: `turnOnRangeRepresentation` to see the reaches.

//: [Next: This is Hear](@next)
