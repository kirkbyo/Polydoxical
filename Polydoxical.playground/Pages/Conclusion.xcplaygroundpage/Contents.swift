import PlaygroundSupport
/*: 
 ## Conclusion
 I hope you found this interesting and had fun exploring the realm of polygons and roulette! If you are interested in learning more about circles, and more specifically cycloids, Vsauce has an amazing [video](https://www.youtube.com/watch?v=skvnj67YGmw) regarding some of the concepts shown in this playground, and they also explore the brachistochrone curve.
 
  As for this final page, I would like to give you the opportunity to create your own *Loupagon* with this template!
 */

let simulator = ConclusionController()
simulator.sides = 6
let node = RotatingNode.create()
node.enviroment.tracer.color = #colorLiteral(red: 0.5096418858, green: 0.9100037813, blue: 0.7164224386, alpha: 1)
node.enviroment.tracer.trailLifeTime = 120
node.enviroment.rotationsPerSide = 3
node.enviroment.movement = .repeats(times: 1)
node.enviroment.tracer.particleBirthRate = 350
simulator.nodes.append(node)

var nodeB = RotatingNode.create()
nodeB.enviroment.rotationsPerSide = 5
nodeB.enviroment.tracer.particleBirthRate = 350
nodeB.position = 4
nodeB.enviroment.tracer.trailLifeTime = 120
nodeB.enviroment.tracer.color = #colorLiteral(red: 0.9500438571, green: 0.916354835, blue: 0.3408567607, alpha: 1)
nodeB.enviroment.movement = .repeats(times: 1)
simulator.nodes.append(nodeB)

//: [Previous](@previous)

//: [Introduction](Introduction) | [Roulette](Roulette) | [Loupagon](Loupagon) | Conclusion

//:---
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = simulator
