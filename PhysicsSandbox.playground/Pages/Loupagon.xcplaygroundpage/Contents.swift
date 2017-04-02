import PlaygroundSupport
import UIKit

/*:
 ## Polydoxical
 Since we have an understanding of what a roulette is, I was curious to see what one would look like that is rolling against the perimiter of
 */



let baseEnv = Enviroment()
baseEnv.tracer.trailLifeTime = 2

//: [Next](@next)
let controller = SimulatorController()
var node = RotatingNode.create(with: baseEnv)
node.position = 1
controller.nodes.append(node)

var xnode = RotatingNode.create(with: baseEnv)
xnode.position = 4
xnode.enviroment.drawPoint = CGPoint(x: 0, y: 0)
controller.nodes.append(xnode)

controller.sides = 12


PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = controller
