//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, addSwimmingBehavior(), addSightRepresentationByLight(), removeSightRepresentationByLight())
//#-code-completion(identifier, show, addSmallSmellToShark(), addMediumSmellToShark(), addLargeSmellToShark())
//#-code-completion(identifier, show, addSmallSightToShark(), addMediumSightToShark(), addLargeSightToShark())
//#-code-completion(identifier, show, addSmallHearingToShark(), addMediumHearingToShark(), addLargeHearingToShark())


import PlaygroundSupport

func addSwimmingBehavior() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("SwimmingBehavior")
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

func addSmallSightToShark() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("AddSmallSightToShark")
        proxy.send(message)
    }
}

func addMediumSightToShark() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("AddMediumSightToShark")
        proxy.send(message)
    }
}

func addLargeSightToShark() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("AddLargeSightToShark")
        proxy.send(message)
    }
}

func addSmallSmellToShark() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("AddSmallSmellToShark")
        proxy.send(message)
    }
}

func addMediumSmellToShark() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("AddMediumSmellToShark")
        proxy.send(message)
    }
}


func addLargeSmellToShark() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("AddLargeSmellToShark")
        proxy.send(message)
    }
}

func addSmallHearingToShark() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("AddSmallHearingToShark")
        proxy.send(message)
    }
}

func addMediumHearingToShark() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("AddMediumHearingToShark")
        proxy.send(message)
    }
}

func addLargeHearingToShark() {
    if let proxy = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler {
        let message: PlaygroundValue = .string("AddLargeHearingToShark")
        proxy.send(message)
    }
}



//#-end-hidden-code

//: ##Build the Shark
//: Once the approach to the features proposed in this manual is finished, it is time to have fun,
//: whether or not to add your behavior, whether or not it is different. :)
//:
//: I'm sure your shark was fed well with all those powerful senses.
//: These are not the only characteristics that a shark possesses,
//: they have many others like hard skin like armor, sharp teeth and a powerful bite,
//: can detect nearby electric fields emitted by other beings, as well as very fast among many others.
//:
//: ###
//: **It's time to build your own shark, TAP below and add whatever you want**
//#-editable-code Tap to enter code
//#-end-editable-code
//:
//: - Important:
//: The Thresher Shark is unfortunately a symbol of the extermination process of the sharks, it is estimated that,
//: as a consequence of predatory fishing, more than 100 million sharks are killed each year.
//:

//: [Next: About Me](@next)

