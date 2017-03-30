//: Playground - noun: a place where people can play

import SpriteKit
import PlaygroundSupport

let env = Enviroment.shared
env.numberOfSides = 3
env.traceDelay = 0.0
env.trailLifeTime = 8
env.rotationsPerSide = 2
env.particleBirthRate = 250
env.mouvement = .infinit

let controller = SimulatorController()

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = controller
