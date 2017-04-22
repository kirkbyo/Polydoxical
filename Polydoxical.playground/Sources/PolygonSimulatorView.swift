import SpriteKit

/// View that simulates the polygon with the rotating nodes
public class PolygonSimulatorView: UIView {
    /// Scene that contains the polygon and the nodes
    public let scene: PolygonScene
    /// Polygon displayed on the screen
    public var polygon: Polygon? {
        didSet {
            scene.polygon = self.polygon
        }
    }
    /// Fill color for the polygon
    public var polygonColor: UIColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    /// Number of sides on the polygon
    public var sides: Int?
    
    override public func draw(_ rect: CGRect) {
        guard let sides = sides else { return }
        guard let context = UIGraphicsGetCurrentContext() else {
            print("[Error] Context could not be created."); return
        }
        
        let centre = CGPoint(x: frame.midX, y: frame.height / 2)
        guard let polygon = Polygon.create(polygonOf: sides, at: centre, size: self.frame.width / 3) else {
            print("[Error] Polygon was not properly created."); return
        }
        context.addPath(polygon.path)
        context.setFillColor(polygonColor.cgColor)
        context.fillPath()
        
        self.polygon = polygon
    }
    
    override public init(frame: CGRect) {
        scene = PolygonScene(size: frame.size)
        super.init(frame: frame)
        let spriteView = SKView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        spriteView.allowsTransparency = true
        self.addSubview(spriteView)
        spriteView.presentScene(scene)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
