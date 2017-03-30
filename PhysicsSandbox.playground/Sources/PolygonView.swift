import SpriteKit

public class PolygonView: UIView {
    
    public var polygon: Polygon?
    public var fillColor: UIColor = Enviroment.shared.polygonColor
    public var sides: Int {
        return Enviroment.shared.numberOfSides
    }
    
    override public func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            print("[Error] Context could not be created."); return
        }

        let centre = CGPoint(x: frame.midX, y: frame.midY)
        guard let polygon = Polygon.create(polygonOf: sides, at: centre, size: self.frame.width / 3) else {
            print("[Error] Polygon was not properly created."); return
        }
        context.addPath(polygon.path)
        context.setFillColor(fillColor.cgColor)
        context.fillPath()
        
        self.polygon = polygon
    }
}
