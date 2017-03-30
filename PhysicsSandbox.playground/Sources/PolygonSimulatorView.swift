import SpriteKit

public class PolygonSimulatorView: PolygonView {
    public let scene: SandboxScene
    
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
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        scene.polygon = self.polygon
    }
}
