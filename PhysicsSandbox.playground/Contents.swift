//: Playground - noun: a place where people can play

import SpriteKit
import PlaygroundSupport

let env = Enviroment.shared
env.numberOfSides = 7
env.traceDelay = 0.0
env.trailLifeTime = 2
env.rotationsPerSide = 2
env.particleBirthRate = 250
env.anchorPoint = CGPoint(x: 0.0, y: 1.0)
env.mouvement = .infinit

let controller = SimulatorController()

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = controller
