//: Playground - noun: a place where people can play

import SpriteKit
import PlaygroundSupport
/*
let sandbox = Sandbox()
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = sandbox
*/

let frame = CGRect(x: 0, y: 0, width: 600, height: 600)
let view = SKView(frame: frame)
let scene = GameScene(size: frame.size)
view.presentScene(scene)
PlaygroundPage.current.liveView = view
