import SpriteKit

public struct RotatingNode {
    public var main: SKNode
    public var referenceEmittingNode: SKNode
    public var enviroment: Enviroment = Enviroment()
    
    public init(node: SKNode, referenceNode: SKNode) {
        self.main = node
        self.referenceEmittingNode = referenceNode
    }
}
