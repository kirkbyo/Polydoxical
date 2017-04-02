import SpriteKit

public struct RotatingNode {
    public var main: SKNode
    public var referenceEmittingNode: SKNode
    public var enviroment: Enviroment = Enviroment()
    
    public init(node: SKNode, referenceNode: SKNode) {
        self.main = node
        self.referenceEmittingNode = referenceNode
    }
    
    static func create(with enviroment: Enviroment) -> RotatingNode {
        let sprite = SKSpriteNode(imageNamed: "Circle.png")
        sprite.size = CGSize(width: 25, height: 25)
        sprite.anchorPoint = enviroment.anchorPoint
        var node = RotatingNode(node: sprite, referenceNode: SKShapeNode())
        node.enviroment = enviroment
        return node
    }
}
