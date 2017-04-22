import PlaygroundSupport
import UIKit

/*:
 ## Loopagon
 *loop + polygon*
 #### Basics
 In this section, we will be exploring the effects of an object rotating around the permitter of a polygon with the hope of yielding some cool patterns.
 
 To begin, we will need to create the controller that will display the pattern. Also, we need to identify how many sides we want on our polygon. The number of sides can be adjusted later in the simulator with the slider.
*/
let simulator = SimulatorController()
simulator.sides = 8
/*:
 Now that we have a polygon and a simulator we need to create nodes that will rotate around the polygon. A node has several traits. It contains the central object that does the rotation around the polygon. There is also an environment unique to that node that allows us to take control of it and adjust it for however we please.
 To create a node, all you have to do is invoke the `create()` method on the `RotatingNode` struct.
 */
var node = RotatingNode.create()
/*:
 We can pick a point from where to start the rotation using the `position` property on the node. It is important to note that the zero position is located on the right side horizontally aligned.
 */
node.position = 2
/*:
 We will also want to give our node a little bit of flare. The color property on the emitter environments allows us to do exactly that.
 */
node.enviroment.tracer.color = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
/*:
 Now to add it to the screen we simply need to append it to the array of rotating nodes on our simulator.
 */
simulator.nodes.append(node)
/*:
 #### Advanced creations
 We will continue to build off the previous node, with the goal of creating a more interesting pattern.
 First, we need to understand all the tools at our disposal.
 - **node.enviroment.anchorPoint**: the point the node rotates around.
 - **node.enviroment.drawPoint**: the point that the tracer is located at on the node.
 - **node.enviroment.followSpeed**: the speed that the object will rotate around the polygon. (measured in points per second).
 - **node.enviroment.movement**: an enumeration that controls if the movement is infinite or it repeats a finite amount of times.
 - **node.enviroment.rotationsPerSide**: The number of rotations the object will do on each side of the polygon.
 - **node.enviroment.traceDelay**: Time interval that expresses the delay between the commencement of movement and the drawing.
 - **node.enviroment.tracer.particleBirthRate**: The spawn rate for the path, if the value is too low, the path will appear like a collection of dots. However, if the birth rate is too high, the simulator will become laggy due to too many objects spawning.
 - **node.enviroment.tracer.trailSize**: The size of the trail being traced.
 
 We will now create three types nodes. One with increased rotations per side and speed. Another default node and finally a node with a slower rate of rotation and a drawing point equal to the perimeter of the polygon.
 */
/*:
 For the increased speed and increased rotation per side we will reuse our first node.
 */
node.enviroment.drawPoint = CGPoint(x: 30, y: 0)
node.enviroment.rotationsPerSide = 2
node.enviroment.followSpeed = 300
node.enviroment.tracer.particleBirthRate = 300
node.enviroment.tracer.trailLifeTime = 4

/*:
 We will create one more common node that has a position of five on the polygon.
 */
var nodeB = RotatingNode.create()
nodeB.position = 5
nodeB.enviroment.tracer.color = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
simulator.nodes.append(nodeB)

/*:
 Finally, we need to create the slower node with the drawing point equal to the perimeter. To do this, we can adjust the `followSpeed` property on the environment and set the draw point to zero for both the horizontal and vertical components.
 */
var nodeC = RotatingNode.create()
nodeC.position = 0
nodeC.enviroment.followSpeed = 150
nodeC.enviroment.drawPoint = CGPoint(x: 0, y: 0)
nodeC.enviroment.tracer.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
nodeC.enviroment.tracer.trailLifeTime = 4
simulator.nodes.append(nodeC)

/*:
 Let's change the color of our background and the polygon, so it fits better with the tracing colors.
 */
simulator.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
simulator.polygonColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)

//: + callout(View your creation!): View your creation with the timeline on the right hand side. Also, you can see how the number of sides influences the pattern by playing with the slider. 

//: [Previous](@previous) | [Next](@next)

//:---
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = simulator
