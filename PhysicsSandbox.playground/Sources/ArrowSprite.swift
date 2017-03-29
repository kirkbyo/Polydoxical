import SpriteKit

enum Direction {
    case left, right, up, down
    case angle(of: Float)
}

class ArrowSprite: SKSpriteNode {
    var lineWidth: CGFloat
    var lineHeight: CGFloat
    
    let textNode: SKLabelNode = SKLabelNode(fontNamed: "Arial")
    
    init(position: CGPoint, lineWidth: CGFloat=5, lineHeight: CGFloat, direction: Direction = .left) {
        self.lineWidth = lineWidth
        let correctedPosition = CGPoint(x: position.x, y: position.y + (lineHeight/2))
        
        self.lineHeight = lineHeight
        super.init(texture: SKTexture(imageNamed: "Arrow-Line"),
                   color: UIColor.red, size: CGSize(width: lineWidth, height: lineHeight))
        self.position = correctedPosition
        
        let head = SKSpriteNode(imageNamed: "Arrow-Head")
        head.size = CGSize(
            width: ((lineWidth * 2) + 5),
            height: ((lineWidth * 2) + 5)
        )
        
        head.position.y += (self.frame.height / 2) + ((head.frame.height - 4) / 2)
        addChild(head)
        setDirection(direction)
        
        textNode.fontSize = 12
        textNode.fontColor = UIColor.black
        addChild(textNode)
        textNode.position = CGPoint(
            x: -textNode.frame.size.width + CGFloat((textNode.text?.characters.count) ?? 0),
            y: textNode.frame.size.height/2
        )
    }
    
    func setDirection(_ direction: Direction) {
        switch direction {
        case .left: self.zRotation = -CGFloat(M_PI_2)
        case .right: self.zRotation = CGFloat(M_PI_2)
        case .up: self.zRotation = 0
        case .down: self.zRotation = -CGFloat(M_PI)
        case .angle(of: let angle): self.zRotation = -CGFloat(M_PI) / CGFloat(angle) // * Float(M_PI/180)
        }
        self.textNode.zRotation = self.zRotation * -1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
