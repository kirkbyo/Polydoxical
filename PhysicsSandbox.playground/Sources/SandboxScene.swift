import SpriteKit

protocol SandboxDelegate {
    func didPause()
}

public class SandboxScene: SKScene {
    /// Shared Enviroment
    let env = Enviroment.shared
    /// Polygon that is being displayed
    public var polygon: Polygon? {
        didSet { startMouvement() }
    }
    
    let sprite: SKSpriteNode
    
    // MARK: - Init
    override public init(size: CGSize) {
        sprite = SKSpriteNode(imageNamed: "Arrow-Head.png")
        super.init(size: size)
        self.backgroundColor = UIColor.clear
        sprite.size = CGSize(width: 30, height: 30)
        sprite.anchorPoint = env.anchorPoint
        addChild(sprite)
    }
    
    // MARK: - Methods
    func startTracing() {
        guard let emitter = SKEmitterNode(fileNamed: "Trail.sks") else { return }
        emitter.targetNode = self
        emitter.particleScale = env.trailSize
        emitter.particleLifetime = env.trailLifeTime
        emitter.particleBirthRate = env.particleBirthRate
        let dotNode = SKShapeNode()
        dotNode.position = env.drawPoint
        sprite.addChild(dotNode)
        dotNode.addChild(emitter)
    }
    
    func startMouvement() {
        guard let polygon = self.polygon else { return }
        /// Action used to follow the dot node around the screen
        var follow = SKAction.follow(polygon.path, asOffset: false, orientToPath: false, speed: env.followSpeed)
        
        /// Angle of the rotation
        let angle: CGFloat = CGFloat(-M_PI)
        /// Determines the amount of time for each rotation to take based on a side. This is too prevent it from becoming out of sync and when the traced lines elasped they don't match
        let rotateDuration = (polygon.sideLength.divided(by: env.followSpeed)).divided(by: env.rotationsPerSide)
        /// Action used to rotate the triangle
        var rotate = SKAction.rotate(byAngle: angle, duration: TimeInterval(rotateDuration))
        
        switch env.mouvement {
        case .infinit:
            follow = SKAction.repeatForever(follow)
            rotate = SKAction.repeatForever(rotate)
        case .repeats(times: let times):
            follow = SKAction.repeat(follow, count: times)
            rotate = SKAction.repeat(rotate, count: times * Int(CGFloat(env.numberOfSides) * env.rotationsPerSide))
        }
        
        let group = SKAction.group([follow, rotate])
        sprite.run(group)
        // Delays the commencement of the drawing
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + env.traceDelay) {
            self.startTracing()
        }
    }

    
    // MARK: - Other
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
