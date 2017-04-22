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

public extension CGFloat {
    func radians() -> CGFloat {
        let b = CGFloat(M_PI) * (self/180)
        return b
    }
}

extension Array {
    func shiftRight(amount: Int = 1) -> [Element] {
        var amount = amount
        assert(-count...count ~= amount, "Shift amount out of bounds")
        if amount < 0 { amount += count }  // this needs to be >= 0
        return Array(self[amount ..< count] + self[0 ..< amount])
    }
}
