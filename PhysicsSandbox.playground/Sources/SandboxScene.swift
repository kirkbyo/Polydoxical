import SpriteKit

protocol SandboxDelegate {
    func didPause()
}

public class SandboxScene: SKScene {
    
    public var point: CGPoint?

    public var path: CGPath? {
        didSet {
            let resultant = sqrt(pow(point!.x, 2) + pow(point!.y, 2)) / 2
            let action = SKAction.repeatForever(SKAction.follow(path!, asOffset: false, orientToPath: false, speed: 200.0))
            // MARK: - TODO
            let angle : Float = Float(-M_PI)
            let rotate = SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(angle), duration: TimeInterval(resultant.divided(by: 200))))
            
            let group = SKAction.group([action, rotate])
            sprite.run(group)
            
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.0) {
                self.startTracing()
            }
        }
    }
    
    func startTracing() {
        let emitter = SKEmitterNode(fileNamed: "Trail.sks")
        emitter!.targetNode = self
        
        let dotNode = SKShapeNode()
        dotNode.position = CGPoint(x: -60, y: 0)
        sprite.addChild(dotNode)
        dotNode.addChild(emitter!)
    }
    
    let sprite: SKSpriteNode
    
    override public init(size: CGSize) {
        sprite = SKSpriteNode(imageNamed: "Arrow-Head.png")
        super.init(size: size)
        self.backgroundColor = UIColor.clear
        sprite.size = CGSize(width: 60, height: 60)
        sprite.anchorPoint = CGPoint(x: 1.0,y: 0.0)
        addChild(sprite)
    }
    
    public override func didChangeSize(_ oldSize: CGSize) {
        //self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func rotateAction() {
    }
}
