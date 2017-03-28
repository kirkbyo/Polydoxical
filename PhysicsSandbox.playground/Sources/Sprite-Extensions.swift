import SpriteKit

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func += ( left: inout CGPoint, right: CGPoint) {
    left = left + right
}

public extension SKNode {
    func centreWithinView(of size: CGSize) {
        let nodeSize = self.frame.size
        self.position = CGPoint(x: (size.width - nodeSize.width/2)/2, y: (size.height - nodeSize.height/2)/2)
    }
}
