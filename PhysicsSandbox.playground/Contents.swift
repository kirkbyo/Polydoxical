//: Playground - noun: a place where people can play

import SpriteKit
import PlaygroundSupport

var ballNode: SKShapeNode = SKShapeNode(circleOfRadius: 30)
let size = CGSize(width: 600, height: 600)
ballNode.centreWithinView(of: size)
ballNode.fillColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
ballNode.physicsBody = SKPhysicsBody(circleOfRadius: 30)
ballNode.physicsBody?.restitution = 0.5
ballNode.physicsBody?.mass = 2.2
ballNode.physicsBody?.allowsRotation = true

let x = SKShapeNode(circleOfRadius: 30)
x.fillColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
x.position = CGPoint(x: 200, y: 200)
x.physicsBody = SKPhysicsBody(circleOfRadius: 30)
x.physicsBody?.restitution = 0.5
x.physicsBody?.mass = 2.2
x.physicsBody?.allowsRotation = true

let frame = CGRect(x: 0, y: 0, width: 600, height: 600)
let view = SKView(frame: frame)
view.showsFPS = true
view.showsPhysics = true

let scene = SandboxScene(size: frame.size)
scene.nodes = [ballNode, x]
view.presentScene(scene)
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = view
