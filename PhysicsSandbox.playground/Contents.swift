//: Playground - noun: a place where people can play

import SpriteKit
import PlaygroundSupport

let frame = CGRect(x: 0, y: 0, width: 500, height: 500)
let view = PolygonView(frame: frame)
view.backgroundColor = UIColor.orange

let sk = SKView(frame: frame)
sk.allowsTransparency = true
view.addSubview(sk)
sk.showsFPS = true
sk.showsPhysics = true

let scene = SandboxScene(size: frame.size)
scene.point = view.point
scene.path = view.path
sk.presentScene(scene)
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = view
