import UIKit

/// Controller that holds the views pertaining to the introduction
public class IntroductionController: UIViewController {
    lazy var simulator: PolygonSimulatorView = {
        return PolygonSimulatorView(frame:
            CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        )
    }()
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let node = RotatingNode.create()
        node.enviroment.tracer.color = UIColor(red:0.604, green:0.639, blue:0.647, alpha:1.000)
        node.enviroment.tracer.trailLifeTime = 2.0
        
        var nodeB = RotatingNode.create()
        nodeB.enviroment.tracer.color = UIColor.black
        nodeB.enviroment.tracer.trailLifeTime = 3.0
        nodeB.enviroment.drawPoint = CGPoint(x: 0, y: 0)
        nodeB.position = 7
        
        self.view.backgroundColor = UIColor.white
        simulator.sides = 12
        simulator.backgroundColor = UIColor.white
        simulator.scene.rotatingNodes = [node, nodeB]
        view.addSubview(simulator)
        
        let label = UILabel()
        label.text = "Welcome to".uppercased()
        label.font = UIFont.systemFont(ofSize: 25)
        label.frame = CGRect(x: (view.frame.width - 300) / 2, y: 50, width: 300, height: 30)
        label.textAlignment = .center
        view.addSubview(label)
        
        let title = UILabel()
        title.text = "Polydoxical".uppercased()
        title.font = UIFont.boldSystemFont(ofSize: 37)
        title.textColor = UIColor(red:0.227, green:0.541, blue:0.898, alpha:1.000)
        title.textAlignment = .center
        title.frame = CGRect(x: (view.frame.width - 300) / 2, y: 90, width: 300, height: 30)
        view.addSubview(title)
    }
}
