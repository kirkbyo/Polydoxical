/*: 
 ## Polydoxical
 Welcome to Polydoxical; my WWDC 17 playground submission. It was built with the goal of teaching and exploring some concepts related to roulettes and the rotation of nodes around polygons.
 The entire project is alt-click friendly, if you are interested in seeing the documentation behind a method or a property.
 
 ### The flow
 1. We will begin with investigating the different types of roulettes.
 2. We will see how polygons and rotating objects interact with each other to create some cool patterns.
 3. You will have the chance to create your own at the end.
 */
//: + callout(Interactive demonstrations): Every page in this playground has an associated interactive demonstration, ensure you have the assistant editior open with the timeline selected to get the fully effect!

/*: 
 [Next](@next)
 */
//: Introduction | [Roulette](Roulette) | [Loupagon](Loupagon) | [Conclusion](Conclusion)

//:---
import PlaygroundSupport

let introduction = IntroductionController()
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = introduction
