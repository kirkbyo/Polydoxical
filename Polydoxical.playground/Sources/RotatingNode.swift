import SpriteKit

/// Node that contains the elements in order to rotate an element around a path.
public struct RotatingNode {
    /// Main node that does the rotating.
    public var main: SKNode
    /// Node that contains the emitter. AKA: The point the drawing is done from.
    public var referenceEmittingNode: SKNode
    /// Information and properties pertaining to this node.
    public var enviroment: Enviroment = Enviroment()
    /// Position of node on polygon.
    public var position: Int?
    
    public init(node: SKNode, referenceNode: SKNode) {
        self.main = node
        self.referenceEmittingNode = referenceNode
    }
    
    /// Creates a node that is able to rotate around a polygon.
    public static func create() -> RotatingNode {
        let sprite = SKSpriteNode(imageNamed: "Triangle.png")
        let enviroment = Enviroment()
        sprite.size = CGSize(width: 30, height: 30)
        sprite.anchorPoint = enviroment.anchorPoint
        var node = RotatingNode(node: sprite, referenceNode: SKShapeNode())
        node.enviroment = enviroment
        return node
    }
}
