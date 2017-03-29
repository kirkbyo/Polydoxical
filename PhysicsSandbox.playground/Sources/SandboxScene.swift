import SpriteKit

protocol SandboxDelegate {
    func didPause()
}

public class SandboxScene: SKScene {
    private var selectedNode: SKNode?
    public var nodes: [SKNode] = [SKNode]() {
        didSet {
            layoutNodes()
        }
    }
    var touchPoint: CGPoint?
    var sandboxDelegate: SandboxDelegate?
    var pausedState: [String: CGVector] = [:]
    var state: SandboxState = .dynamic
    let env = Environment.shared
    
    enum SandboxState {
        case dynamic
        case paused
        
        mutating func inverse() {
            switch self {
            case .dynamic:
                self = .paused
            case .paused:
                self = .dynamic
            }
        }
    }
    
    override public init(size: CGSize) {
        super.init(size: size)
        layoutNodes()
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    public override func didChangeSize(_ oldSize: CGSize) {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func pauseMouvement() {
        state.inverse()
        for node in nodes {
            guard let name = node.name else { continue }
            guard let nodeBody = node.physicsBody else { continue }
            switch state {
            case .paused:
                pausedState[name] = nodeBody.velocity
                addDirectionalArrows(node: node)
                nodeBody.isDynamic = false
            case .dynamic:
                removeArrows()
                nodeBody.isDynamic = true
                guard let previousVelocity = pausedState[name] else { break }
                nodeBody.velocity = previousVelocity
                pausedState[name] = nil
            }
        }
        sandboxDelegate?.didPause()
    }
    
    func layoutNodes() {
        for node in self.nodes {
            if node.name == nil {
                node.name = UUID().uuidString
            }
            addChild(node)
        }
    }
    
    var arrows: [ArrowSprite] = [ArrowSprite]()
    
    func addDirectionalArrows(node: SKNode) {
        guard let body = node.physicsBody else { return }
        if body.mass > 0 {
            let gravitationalForce: CGFloat = roundNum(body.mass * CGFloat(env.gravity))
            // TODO: Replace 35 with object hitbox size + 5
            let gravityArrow = ArrowSprite(
                position: node.position + CGPoint(x: 0, y: -55),
                lineHeight: gravitationalForce,
                direction: .down
            )
            
            gravityArrow.textNode.text = "Fg = \(gravitationalForce) m/s^2"
            addChild(gravityArrow)
            arrows.append(gravityArrow)
        }
        
        let angleOfVelocity = Float(atan(body.velocity.dy / body.velocity.dx))
        print(angleOfVelocity)
        let velocityArrow = ArrowSprite(
            position: node.position,
            lineHeight: 25,
            direction: .angle(of: -angleOfVelocity)
        )
        velocityArrow.textNode.text = "V = \(body.angularVelocity) m/s"
        addChild(velocityArrow)
        arrows.append(velocityArrow)
 
    }
    
    func removeArrows() {
        for arrow in arrows {
            arrow.removeFromParent()
        }
    }
    
    func roundNum(_ number: CGFloat) -> CGFloat {
        return CGFloat(round(number * 1000) / 1000.0)
    }
    
    // MARK: - Touch Delegates
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if touch.tapCount == 2 {
            pauseMouvement()
            return
        }
        
        let location = touch.location(in: self)
        if let touchedNode = self.nodes(at: location).first {
            touchPoint = location
            selectedNode = touchedNode
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        touchPoint = location
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchPoint = nil
        selectedNode = nil
    }
    
    // MARK: - Game Loop Delegate
    public override func update(_ currentTime: CFTimeInterval) {
        super.update(currentTime)
        
        guard let touchPoint = self.touchPoint else { return }
        guard let selectedNode = self.selectedNode else { return }
        let dt: CGFloat = 1.0/60.0
        let distance = CGVector(
            dx: touchPoint.x - selectedNode.position.x,
            dy: touchPoint.y - selectedNode.position.y
        )
        let velocity = CGVector(dx: distance.dx / dt, dy: distance.dy / dt)
        selectedNode.physicsBody?.velocity = velocity
    }
}
