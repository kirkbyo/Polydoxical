import SpriteKit

/// Scene to test out the different types of roulettes.
public class RouletteScene: SKScene {
    // MARK: - Properties
    /// Nodes that will be rotating to show the different types of roulettes
    private var rotatingNodes = [RotatingNode]()
    /// Standard enviroment for the emitter nodes
    private let emitterEnviroment = EmitterEnviroment()
    /// All the lines that connect the drawing point to the centre point
    private var connectingLines = [SKShapeNode]()
    /// Radius of the nodes that are rotating
    internal let nodeRadius: CGFloat = 15
    /// Color of the line that is connecting the drawing point to the centre
    private let lineColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    /// Color of the trail
    private let trailColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    /// Length of the prolated roulette example. Note: prolatedLength > nodeRadius.
    private lazy var prolatedLength: CGFloat = {
        return self.nodeRadius * 2 + 10
    }()
    /// Length of the curtated roulette example. Note: curtateLength < nodeRadius
    private lazy var curateLength: CGFloat = {
        return self.nodeRadius - 2
    }()
    
    enum Roulette: String {
        case trochoid, curtate, prolate
        static let allValues = [trochoid, curtate, prolate]
        
        static func from(_ str: String) -> Roulette? {
            for type in Roulette.allValues {
                if str.lowercased() == type.rawValue {
                    return type
                }
            }
            return nil
        }
    }
    
    // MARK: - Init
    override public init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        emitterEnviroment.particleBirthRate = 350
        emitterEnviroment.trailSize = 0.05
        emitterEnviroment.trailLifeTime = 7
        
        let trochoidLabel = createTextLabel(text: "Trochoid")
        addChild(trochoidLabel)
        trochoidLabel.position = CGPoint(x: (trochoidLabel.frame.width / 2) + 20, y: size.height - 30)
        
        let trochoid = RotatingNode(node: createNode(), referenceNode: SKShapeNode())
        trochoid.main.name = Roulette.trochoid.rawValue
        trochoid.main.position = CGPoint(x: 0, y: size.height - 70)
        trochoid.enviroment.drawPoint = CGPoint(x: nodeRadius, y: nodeRadius)
        addChild(trochoid.main)
        
        let curtate = RotatingNode(node: createNode(), referenceNode: SKShapeNode())
        curtate.main.name = Roulette.curtate.rawValue
        curtate.main.position = CGPoint(x: 0, y: (size.height - nodeRadius * 2) / 2)
        curtate.enviroment.drawPoint = CGPoint(x: curateLength * 2, y: curateLength)
        addChild(curtate.main)
        
        let curtateLabel = createTextLabel(text: "Curtate")
        addChild(curtateLabel)
        curtateLabel.position = CGPoint(x: (curtateLabel.frame.width / 2) + 20, y: curtate.main.position.y + 50)
        
        let prolate = RotatingNode(node: createNode(), referenceNode: SKShapeNode())
        prolate.main.name = Roulette.prolate.rawValue
        prolate.main.position = CGPoint(x: 0, y: 40)
        prolate.enviroment.drawPoint = CGPoint(x: prolatedLength, y: nodeRadius)
        addChild(prolate.main)
        
        let prolateLabel = createTextLabel(text: "Prolate")
        addChild(prolateLabel)
        prolateLabel.position = CGPoint(x: (prolateLabel.frame.width / 2) + 20, y: prolate.main.position.y + 55)
        
        rotatingNodes.append(contentsOf: [trochoid, curtate, prolate])
    }
    
    func createTextLabel(text: String) -> SKLabelNode {
        let trochoidLabel = SKLabelNode(text: text)
        trochoidLabel.color = UIColor.white
        trochoidLabel.fontSize = 18
        trochoidLabel.fontName = "HelveticaNeue-Bold"
        return trochoidLabel
    }
    
    
    /// Creates a circular sprite that will act as a rotating node
    ///
    /// - Returns: Circle sprite node
    private func createNode() -> SKSpriteNode {
        let sprite = SKSpriteNode(imageNamed: "Circle.png")
        sprite.size = CGSize(width: nodeRadius * 2, height: nodeRadius * 2)
        sprite.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        return sprite
    }
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        startTracing()
    }
    
    // MARK: - Methods
    /// Starts the tracing based on it's parent objects mouvement.
    func startTracing() {
        for node in rotatingNodes {
            guard let emitter = SKEmitterNode(fileNamed: "Trail.sks") else { print("Trail Texture not found"); break }
            /// Configures the enviroment for the emitter
            emitter.targetNode = self
            emitter.particleScale = emitterEnviroment.trailSize
            emitter.particleLifetime = emitterEnviroment.trailLifeTime
            emitter.particleBirthRate = emitterEnviroment.particleBirthRate
            emitter.particleColorSequence = nil
            emitter.particleColorBlendFactor = 1.0
            emitter.particleColor = lineColor
            /// Sets the position of the emiting node point and adds it to the screen
            node.referenceEmittingNode.position = node.enviroment.drawPoint
            node.referenceEmittingNode.addChild(emitter)
            node.main.addChild(node.referenceEmittingNode)
        }
    }
    
    
    /// Rotates the emitting node point based on a percentage. Percentages range from 0.0 to 1.0.
    ///
    /// - Parameter percentage: Percentage to rotate the node
    public func rotateReferencePoint(percentage: Float) {
        /// Removes the previous connecting lines
        for line in connectingLines { line.removeFromParent() }
        
        for node in rotatingNodes {
            guard node.main.name != Roulette.trochoid.rawValue else {
                node.referenceEmittingNode.position = node.enviroment.drawPoint
                continue
            }
            guard let name = node.main.name else { continue }
            guard let type = Roulette.from(name) else { continue }
            let period: Double = 4
            
            // Sets the length from the centre to the drawing point based on the type of trochoid.
            let length: CGFloat = (type == .curtate ? curateLength: prolatedLength)
            /// Gets the radian angle for a percentage of a typical 2 pi cycle.
            let point = 2 * M_PI * Double(-percentage)
            // Gets the x and y position from the angle.
            let x = length * CGFloat(cos(period * point))
            let y = length * CGFloat(sin(period * point))
            // Sets the emiting node to it's new position based on the angle
            node.referenceEmittingNode.position = CGPoint(x: nodeRadius, y: nodeRadius) + CGPoint(x: x, y: y)
            
            // Adds a line connecting the centre to the drawing point
            addLineTo(node: node.main, with: node.referenceEmittingNode.position)
        }
    }
    
    
    /// Adds line from a position to the centre of a rotating node.
    ///
    /// - Parameters:
    ///   - node: Node to add line too
    ///   - position: position to add the line to
    private func addLineTo(node: SKNode, with position: CGPoint) {
        let path = CGMutablePath()
        path.move(to: position)
        path.addLine(to: CGPoint(x: nodeRadius, y: nodeRadius))
        path.closeSubpath()
        
        let shape = SKShapeNode()
        shape.path = path
        shape.strokeColor = lineColor
        shape.lineWidth = 2
        node.addChild(shape)
        connectingLines.append(shape)
    }
    
    
    /// Move all the rotating nodes to a new horizontal position.
    ///
    /// - Parameter position: New x position for the nodes
    public func moveRotatingNodesHorizontallyTo(position: CGFloat) {
        for node in rotatingNodes {
            node.main.position.x = position
        }
    }
    
    func updateDraw(length: CGFloat, for type: Roulette) {
        for node in rotatingNodes {
            guard let name = node.main.name else { continue }
            guard let nodeType = Roulette.from(name) else { continue }
            guard type == nodeType else { continue }
            node.enviroment.drawPoint.x = length
            node.referenceEmittingNode.position = node.enviroment.drawPoint
            switch type {
            case .curtate:
                curateLength = length
            case .prolate:
                prolatedLength = length
            default: break
            }
            break
        }
    }
    
    // MARK: - Other
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
