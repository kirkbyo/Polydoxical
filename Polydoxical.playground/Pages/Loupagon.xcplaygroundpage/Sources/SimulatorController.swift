import UIKit

/// Controller that simulates the creation of a loupagon
public class SimulatorController: UIViewController {
    // MARK: - Properties
    /// Simulator for the nodes
    lazy var simulator: PolygonSimulatorView = {
        return PolygonSimulatorView(frame:
            CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        )
    }()
    /// Slider that controls the amount of sides on the polygon
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
    /// Nodes that will rotate around the polygon
    public var nodes: [RotatingNode] = [RotatingNode]()
    /// Amount of sides on the polygon
    public var sides: Int = 4
    /// Background color of the simulator
    public var backgroundColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    /// Fill color of the polygon
    public var polygonColor: UIColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    
    // MARK: - Controller Delegate
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.white
        simulator.backgroundColor = backgroundColor
        simulator.scene.rotatingNodes = nodes
        simulator.sides = sides
        simulator.polygonColor = self.polygonColor
        view.addSubview(simulator)
        
        sideSlider.frame.origin = CGPoint(x: (view.frame.width - 280)/2, y: simulator.frame.height + 40)
        view.addSubview(sideSlider)
        sideSlider.setValue(Float(sides), animated: false)
    }
    
    // MARK: - Methods
    /// Updates the polygon sides based on the sliders value
    func sidesSliderValueChanged() {
        let newSideValue = Int(round(sideSlider.value))
        sides = newSideValue
        simulator.sides = sides
        simulator.setNeedsDisplay()
    }
}
