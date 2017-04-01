import UIKit
import SpriteKit

public class RouletteController: UIViewController {
    /// Slider to control the position of the rolling nodes.
    let positionSlider: UISlider = {
        let slider = UISlider()
        slider.frame = CGRect(x: 20, y: 0, width: 280, height: 20)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.value = 0
        slider.addTarget(self, action: #selector(RouletteController.positionSliderValueChanged),for: .valueChanged)
        slider.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        return slider
    }()
    
    
    let curtateSlider: UISlider = {
        let slider = UISlider()
        slider.frame = CGRect(x: 20, y: 0, width: 120, height: 20)
        slider.minimumValue = 1
        slider.isContinuous = true
        slider.value = 1
        slider.addTarget(self, action: #selector(RouletteController.curtateReferencePointLengthChanged),for: .valueChanged)
        slider.tintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        return slider
    }()
    
    let prolateSlider: UISlider = {
        let slider = UISlider()
        slider.frame = CGRect(x: 20, y: 0, width: 120, height: 20)
        slider.isContinuous = true
        slider.value = 1
        slider.addTarget(self, action: #selector(RouletteController.prolateReferencePointLengthChanged),for: .valueChanged)
        slider.tintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        return slider
    }()
    
    var rouletteScene: RouletteScene?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(positionSlider)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let sliderXPosition = (view.frame.width - positionSlider.frame.width)/2
        positionSlider.frame.origin = CGPoint(x: sliderXPosition, y: view.frame.size.height - 350)
        configureRouletteScene()
        layoutAdditionSliders()
    }
    
    func layoutAdditionSliders() {
        guard let scene = rouletteScene else { print(["[Error] scene not configured."]);
            return }
        func label() -> UILabel {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
            label.textAlignment = .center
            return label
        }
        let nodeRadius = scene.nodeRadius
        // ---- Curtate Section
        let curtateLabel = label()
        curtateLabel.frame = CGRect(x: 20, y: positionSlider.frame.origin.y + 40, width: 120, height: 25)
        curtateLabel.text = "Curtate Length"
        view.addSubview(curtateLabel)
        
        curtateSlider.frame.origin = CGPoint(x: 20, y: curtateLabel.frame.origin.y + 35)
        curtateSlider.minimumValue = 1.0
        curtateSlider.maximumValue = Float(nodeRadius)
        view.addSubview(curtateSlider)
        curtateSlider.setValue(Float(nodeRadius) - 2, animated: false)
        // ---- Prolate Section
        let prolateLabel = label()
        prolateLabel.frame = CGRect(x: view.frame.width - 140, y: positionSlider.frame.origin.y + 40, width: 120, height: 25)
        prolateLabel.text = "Prolate Length"
        view.addSubview(prolateLabel)
        
        prolateSlider.frame.origin = CGPoint(
            x: view.frame.width - 140,
            y: curtateLabel.frame.origin.y + 35
        )
        prolateSlider.minimumValue = Float(nodeRadius * 2) + 1
        prolateSlider.maximumValue = Float(nodeRadius * 2) + 20
        view.addSubview(prolateSlider)
        prolateSlider.setValue(Float(nodeRadius * 2) + 10, animated: false)
    }
    
    func configureRouletteScene() {
        let sceneFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300)
        let scene = RouletteScene(size: sceneFrame.size)
        rouletteScene = scene
        let spriteView = SKView(frame: sceneFrame)
        spriteView.allowsTransparency = true
        self.view.addSubview(spriteView)
        spriteView.showsFPS = true
        spriteView.presentScene(scene)
        view.addSubview(spriteView)
    }
    
    func positionSliderValueChanged() {
        guard let scene = rouletteScene else { return }
        let value = positionSlider.value / 100
        scene.rotateReferencePoint(percentage: value)
        
        let sideSpacing = 5
        let maxDistance = self.view.frame.width - CGFloat(sideSpacing * 2) - scene.nodeRadius
        scene.moveRotatingNodesHorizontallyTo(position: CGFloat(maxDistance) * CGFloat(value))
    }
    
    func curtateReferencePointLengthChanged() {
        guard let scene = rouletteScene else { return }
        let value = round(curtateSlider.value)
        scene.updateDraw(length: CGFloat(value), for: .curtate)
    }
    
    func prolateReferencePointLengthChanged() {
        guard let scene = rouletteScene else { return }
        let value = round(prolateSlider.value)
        scene.updateDraw(length: CGFloat(value), for: .prolate)
    }
}
