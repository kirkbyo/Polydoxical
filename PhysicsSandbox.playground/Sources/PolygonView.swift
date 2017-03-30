import SpriteKit

func polygonPointArray(sides:Int,x:CGFloat,y:CGFloat,radius:CGFloat,offset:CGFloat)->[CGPoint] {
    let angle = (360/CGFloat(sides)).radians()
    let cx = x // x origin
    let cy = y // y origin
    let r = radius // radius of circle
    var i = 0
    var points = [CGPoint]()
    while i <= sides {
        let xpo = cx + r * cos(angle * CGFloat(i) - offset.radians())
        let ypo = cy + r * sin(angle * CGFloat(i) - offset.radians())
        points.append(CGPoint(x: xpo, y: ypo))
        i += 1
    }
    return points
}

func polygonPath(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, offset: CGFloat) -> (CGPath, CGPoint) {
    let path = CGMutablePath()
    let points = polygonPointArray(sides: sides,x: x,y: y,radius: radius, offset: offset)
    let difference = points[1] - points[0]
    let cpg = points[0]
    path.move(to: cpg)
    for p in points {
        path.addLine(to: p)
    }
    path.closeSubpath()
    return (path, difference)
}

func drawPolygonBezier(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, color:UIColor, offset:CGFloat) -> UIBezierPath {
    let path = polygonPath(x: x, y: y, radius: radius, sides: sides, offset: offset)
    let bez = UIBezierPath(cgPath: path.0)
    // no need to convert UIColor to CGColor when using UIBezierPath
    color.setFill()
    bez.fill()
    return bez
}

func drawPolygonUsingPath(ctx:CGContext, x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, color:UIColor, offset:CGFloat) -> (CGPath, CGPoint) {
    let path = polygonPath(x: x, y: y, radius: radius, sides: sides, offset: offset)
    ctx.addPath(path.0)
    let cgcolor = color.cgColor
    ctx.setFillColor(cgcolor)
    ctx.fillPath()
    return path
}

public class PolygonView: UIView {
    
    public var path: CGPath = CGPath(ellipseIn: CGRect(), transform: nil)
    public var point: CGPoint = CGPoint()
    
    override public func draw(_ rect: CGRect) {
        print("DRAWEDDD")
        let ctx = UIGraphicsGetCurrentContext()
        
        (path, point) = drawPolygonUsingPath(ctx: ctx!, x: rect.midX,y: rect.midY,radius: rect.width/3, sides: 13, color: UIColor.blue, offset:0)
        
        //drawPolygonBezier(x: rect.midX,y: rect.midY,radius: rect.width/4, sides: 4, color: UIColor.yellow, offset:0)
    }
}
