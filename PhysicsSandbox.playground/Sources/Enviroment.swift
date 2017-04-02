import UIKit

public class Enviroment {
    /// Enum defining the mouvement of the rotating object around the polygon
    public enum Mouvement {
        case repeats(times: Int)
        case infinit
    }
    
    /// Number of rotations per each side of the polygon
    /// Note: If the number of sides is an odd number and the rotations per side is odd also, it will produce a different patern then the one before it.
    public var rotationsPerSide: CGFloat = 2
    /// Spped at which the line tracer mouves
    public var followSpeed: CGFloat = 200
    /// Point on which the line draw will do it's thing from
    public var drawPoint: CGPoint = CGPoint(x: -30, y: 0)
    /// Point that the sprite rotates on
    public var anchorPoint: CGPoint = CGPoint(x: 1.0,y: 0.0)
    /// Determines if the mouvement repeats forever or if it just repeats a certain amount of times
    public var mouvement: Mouvement = .infinit
    /// Number of sides on the polygon
    public var numberOfSides: Int = 6
    /// Delay between the commencement of the mouvement and the commencement of the tracing
    public var traceDelay: TimeInterval = 0.5
    /// Properties for the emitter that traces the path of an object
    public var tracer: EmitterEnviroment = EmitterEnviroment()
    
    public init() {}
}

public class EmitterEnviroment {
    /// Scale of the trail. Higher scale bigger the width/height of trail will be. (Defaults to 0.1)
    public var trailSize: CGFloat = 0.1
    /// Trail life time in seconds. Determines how long the trail lasts on screen for after being added. (Defaults to 11.0)
    public var trailLifeTime: CGFloat = 5.0
    /// Particle emition. The amount of particles released every second. Defaults to 200.
    public var particleBirthRate: CGFloat = 200
    
    public init() {}
}
