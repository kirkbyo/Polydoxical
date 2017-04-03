import UIKit

/// Controller that contains two simulators. One customizable, one precreated.
public class ConclusionController: UIViewController {
    /// Customizable simulator
    lazy var simulatorA: PolygonSimulatorView = {
        return PolygonSimulatorView(frame:
            CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 2)
        )
    }()
    
    /// Precreated simulator
    lazy var simulatorB: PolygonSimulatorView = {
        let simA = self.simulatorA.frame.height
        let difference = self.view.frame.height - simA
        return PolygonSimulatorView(frame:
            CGRect(x: 0, y: simA, width: self.view.frame.width, height: difference)
        )
    }()
    /// Nodes to be shown with in the simulator
    public var nodes: [RotatingNode] = [RotatingNode]()
    /// Number of sides on the polygon
    public var sides: Int = 4
    /// Color of the background
    public var backgroundColor: UIColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    /// Fill color for the polygon
    public var polygonColor: UIColor = #colorLiteral(red: 0, green: 0.4799527526, blue: 1, alpha: 1)
    
    // MARK: - Controler Delegates
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.white
        
        simulatorA.backgroundColor = backgroundColor
        simulatorA.scene.rotatingNodes = nodes
        simulatorA.sides = sides
        simulatorA.polygonColor = self.polygonColor
        view.addSubview(simulatorA)
 
        simulatorB.backgroundColor = UIColor(red:0.918, green:0.965, blue:1.000, alpha:1.000)
        simulatorB.scene.rotatingNodes = configureSimB()
        simulatorB.sides = 12
        simulatorB.polygonColor = UIColor(red:0.137, green:0.145, blue:0.157, alpha:1.000)
        view.addSubview(simulatorB)
    }
    
    // MARK: - Methods
    private func configureSimB() -> [RotatingNode] {
        var nodes = [RotatingNode]()
        var nodeA = RotatingNode.create()
        nodeA.enviroment.tracer.color = UIColor(red:0.000, green:0.624, blue:0.992, alpha:1.000)
        nodeA.enviroment.tracer.trailLifeTime = 4
        nodeA.position = 0
        nodeA.enviroment.tracer.particleBirthRate = 150
        nodeA.enviroment.followSpeed = 50
        nodeA.enviroment.movement = .repeats(times: 5)
        nodes.append(nodeA)
        
        var nodeB = RotatingNode.create()
        nodeB.enviroment.tracer.color = UIColor(red:1.000, green:0.643, blue:0.000, alpha:1.000)
        nodeB.position = 5
        nodeB.enviroment.tracer.trailLifeTime = 4
        nodeB.enviroment.tracer.particleBirthRate = 150
        nodeB.enviroment.followSpeed = 50
        nodeB.enviroment.movement = .repeats(times: 5)
        nodes.append(nodeB)
        return nodes
    }
}
