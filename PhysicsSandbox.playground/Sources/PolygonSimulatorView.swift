import SpriteKit

public class PolygonSimulatorView: UIView {
    public let scene: SandboxScene
    public var polygon: Polygon? {
        didSet {
            scene.polygon = self.polygon
        }
    }
    
    override public func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            print("[Error] Context could not be created."); return
        }
        
        let centre = CGPoint(x: frame.midX, y: frame.midY)
        guard let polygon = Polygon.create(polygonOf: 7, at: centre, size: self.frame.width / 3) else {
            print("[Error] Polygon was not properly created."); return
        }
        context.addPath(polygon.path)
        context.setFillColor(UIColor.red.cgColor)
        context.fillPath()
        
        self.polygon = polygon
    }
    
    override public init(frame: CGRect) {
        scene = SandboxScene(size: frame.size)
        super.init(frame: frame)
        let spriteView = SKView(frame: frame)
        spriteView.allowsTransparency = true
        self.addSubview(spriteView)
        spriteView.showsFPS = true
        spriteView.presentScene(scene)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
