import UIKit


/// Create customizable polygons from points
public class Polygon {
    /// Length of each side of the polygon
    public var sideLength: CGFloat
    /// Path of the polygon
    public var path: CGPath
    
    init(sideLength: CGFloat, path: CGPath) {
        self.sideLength = sideLength
        self.path = path
    }
    
    
    /// Creates an array of points of the polygon based on the provided information.
    ///
    /// - Parameters:
    ///   - sides: Number of sides on the polygon
    ///   - point: Centre point of the polygon
    ///   - radius: Size of the drawing board that the polygon will be created on
    ///   - offset: Offset the points of the polygon
    fileprivate static func createArrayOfPoints(sides: Int, at point: CGPoint, radius: CGFloat, offset: CGFloat) -> [CGPoint] {
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
    
    
    /// Creates a polygon based on the provided information.
    ///
    /// - Parameters:
    ///   - sides: Number of sides on the polygon
    ///   - point: Centre point of the polygon
    ///   - size: Size of the drawing board that the polygon will be created on
    ///   - offset: Offset the points of the polygon (defaults to 0)
    public static func create(polygonOf sides: Int, at point: CGPoint, size: CGFloat, offset: CGFloat=0) -> Polygon? {
        let path = CGMutablePath()
        let points = createArrayOfPoints(sides: sides, at: point, radius: size, offset: offset)
        guard points.indices.count > 2 else { return nil }
        
        let start = points[0]
        path.move(to: start)
        for point in points {
            path.addLine(to: point)
        }
        path.closeSubpath()
        
        let difference = points[1] - points[0]
        let sideLength = sqrt(pow(difference.x, 2) + pow(difference.y, 2))
        return Polygon(sideLength: sideLength, path: path)
    }
}
