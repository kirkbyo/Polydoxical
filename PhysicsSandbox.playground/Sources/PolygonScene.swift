import SpriteKit

protocol SandboxDelegate {
    func didPause()
}

public class SandboxScene: SKScene {
    /// Polygon that is being displayed
    public var polygon: Polygon? {
        didSet {
            moveNodes()
        }
    }
    
    public var rotatingNodes = [RotatingNode]() {
        didSet {
            addRotatingNodes()
        }
    }
    
    // MARK: - Init
    override public init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.clear
    }
    
    func moveNodes() {
        guard let polygon = polygon else { return }
        var shift: Int = 0
        for node in rotatingNodes {
            shift += 1
            node.main.removeAllActions()
            node.referenceEmittingNode.removeAllActions()
            node.main.removeAllChildren()
            
            let centre = CGPoint(x: frame.midX, y: frame.midY)
            guard let polygon = Polygon.create(polygonOf: polygon.sides, at: centre, size: self.frame.width / 3, shift: (node.position ?? shift)) else {
                print("[Error] Polygon was not properly created."); return
            }
            follow(path: polygon.path, for: node)
            startTracing(for: node)
        }
    }
    
    func addRotatingNodes() {
        for node in rotatingNodes {
            guard node.main.parent == nil else { continue }
            node.main.position = CGPoint(x: 100, y: 100)
            addChild(node.main)
        }
    }
    
    func startTracing(for node: RotatingNode) {
        guard let emitter = SKEmitterNode(fileNamed: "Trail.sks") else { return }
        let env = node.enviroment.tracer
        emitter.targetNode = self
        emitter.particleScale = env.trailSize
        emitter.particleLifetime = env.trailLifeTime
        emitter.particleBirthRate = env.particleBirthRate
        let dotNode = SKShapeNode()
        dotNode.position = node.enviroment.drawPoint
        print(node.enviroment.drawPoint)
        node.main.addChild(dotNode)
        
        // Delays the commencement of the drawing
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + node.enviroment.traceDelay) {
            dotNode.addChild(emitter)
        }
    }
    
    func follow(path: CGPath, for node: RotatingNode) {
        guard let polygon = self.polygon else { return }
        let env = node.enviroment
        /// Action used to follow the dot node around the screen
        var follow = SKAction.follow(path, asOffset: false, orientToPath: false, speed: env.followSpeed)
        
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
        node.main.run(group)
    }
    
    // MARK: - Methods
    
    // MARK: - Other
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
