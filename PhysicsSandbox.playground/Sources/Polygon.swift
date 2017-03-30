import UIKit

class Polygon {
    typealias Path = (path: CGPath, sideLength: CGFloat)
    
    private func createArrayOfPoints(sides: Int, at point: CGPoint, radius: CGFloat, offset: CGFloat) -> [CGPoint] {
        let angle = (360/CGFloat(sides)).radians()
        var i = 0
        var points = [CGPoint]()
        while i <= sides {
            let xPosition = point.x + radius * cos(angle * CGFloat(i) - offset.radians())
            let yPosition = point.y + radius * sin(angle * CGFloat(i) - offset.radians())
            points.append(CGPoint(x: xPosition, y: yPosition))
            i += 1
        }
        return points
    }
    
    private func pathFromPoints(sides: Int, at point: CGPoint, radius: CGFloat, offset: CGFloat) -> Path? {
        let path = CGMutablePath()
        let points = createArrayOfPoints(sides: sides, at: point, radius: radius, offset: offset)
        guard points.indices.count > 2 else { return nil }
        
        let start = points[0]
        path.move(to: start)
        for point in points {
            path.addLine(to: point)
        }
        path.closeSubpath()
        
        let difference = points[1] - points[0]
        let sideLength = sqrt(pow(difference.x, 2) + pow(difference.y, 2))
        return (path: path, sideLength)
    }
    
}
/*
func drawPolygonUsingPath(ctx:CGContext, x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, color:UIColor, offset:CGFloat) -> (CGPath, CGPoint) {
    let path = polygonPath(x: x, y: y, radius: radius, sides: sides, offset: offset)
    ctx.addPath(path.0)
    let cgcolor = color.cgColor
    ctx.setFillColor(cgcolor)
    ctx.fillPath()
    return path
}
 */
