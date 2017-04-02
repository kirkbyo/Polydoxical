import UIKit

public class SimulatorController: UIViewController {
    
    lazy var simulator: PolygonSimulatorView = {
        return PolygonSimulatorView(frame:
            CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        )
    }()
    
    let sideSlider: UISlider = {
        let slider = UISlider()
        slider.frame = CGRect(x: 20, y: 0, width: 280, height: 20)
        slider.minimumValue = 3
        slider.maximumValue = 25
        slider.isContinuous = true
        slider.value = 0
        slider.addTarget(self, action: #selector(SimulatorController.sidesSliderValueChanged),for: .valueChanged)
        slider.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        return slider
    }()
    
    public var nodes: [RotatingNode] = [RotatingNode]()
    public var sides: Int = 4
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.white
        simulator.backgroundColor = UIColor.blue
        simulator.scene.rotatingNodes = nodes
        simulator.sides = sides
        view.addSubview(simulator)
        
        sideSlider.frame.origin = CGPoint(x: (view.frame.width - 280)/2, y: simulator.frame.height + 40)
        view.addSubview(sideSlider)
        sideSlider.setValue(Float(sides), animated: false)
    }
    
    func sidesSliderValueChanged() {
        let newSideValue = Int(round(sideSlider.value))
        sides = newSideValue
        simulator.sides = sides
        simulator.setNeedsDisplay()
    }
}
