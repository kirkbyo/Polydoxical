import SpriteKit

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func += ( left: inout CGPoint, right: CGPoint) {
    left = left + right
}

public class GameScene: SKScene {
    var selectedNode: SKNode?
    var shakeAction: SKAction?
    
    override public init(size: CGSize) {
        let text = SKLabelNode(text: "Drag me 🤖")
        text.fontColor = #colorLiteral(red: 0.854901969432831, green: 0.250980406999588, blue: 0.47843137383461, alpha: 1.0)
        text.position = CGPoint(x: size.width / 2, y: size.height/2)
        text.physicsBody = SKPhysicsBody(rectangleOf: text.frame.size)
        text.physicsBody?.restitution = 1.0;
        text.physicsBody?.friction = 0.0;
        text.physicsBody?.linearDamping = 0.0;
        text.physicsBody?.angularDamping = 0.0;
        
        let sprite = SKSpriteNode(color: #colorLiteral(red: 0.854901969432831, green: 0.250980406999588, blue: 0.47843137383461, alpha: 1.0), size: CGSize(width: 30, height: 30))
        sprite.position = CGPoint(x: 125, y: 150)
        sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 30))
        sprite.physicsBody?.restitution = 1.0;
        sprite.physicsBody?.friction = 0.0;
        sprite.physicsBody?.linearDamping = 0.0;
        sprite.physicsBody?.angularDamping = 0.0;
        super.init(size: size)
        addChild(text)
        addChild(sprite)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let positionInScene = touch?.location(in: self) else {return}
        
        if let touchedNode = self.nodes(at: positionInScene).first {
            selectedNode = touchedNode
        }
        
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let translationInScene = touch.location(in: self) - touch.previousLocation(in: self)
        if let selected = selectedNode {
            selected.position += translationInScene
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if selectedNode != nil {
            selectedNode?.removeAction(forKey: "shake")
            selectedNode = nil
        }
    }
}
