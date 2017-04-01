import SpriteKit
import PlaygroundSupport

/*: 
 ## Super Sweet Name
 Welcome to my WWDC 17 playground submission. This playground was built to explore some concepts and to also see how you can create some cool patterns and animatation with polygons and roulettes. 
 
 The entire project is alt-click friendly.
 */


let env = Enviroment.shared
env.mouvement = .infinit

let controller = SimulatorController()

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = controller
