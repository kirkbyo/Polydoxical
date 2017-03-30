import UIKit


public class SimulatorController: UIViewController {
    
    lazy var simulator: PolygonSimulatorView = {
        return PolygonSimulatorView(frame:
            CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        )
    }()
    
    var setCustomSize: Bool = true
    
    public override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.white
        simulator.backgroundColor = Enviroment.shared.backgroundColor
        view.addSubview(simulator)
    }
}
