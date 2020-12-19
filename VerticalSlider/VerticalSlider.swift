// Created 2020/11/11
// Using Swift 5.0

import UIKit

public protocol VerticalSliderDelegate: class {
    func setToUpperRange(_ value: Double)
    func setToLowerRange(_ value: Double)
    func setToMiddleRange(_ value: Double)
    //func didReceivePortOutputCommandFeedback(_ hub: Hub, _ port: HubPort, _ Message: UInt8)
}

@IBDesignable public class VerticalSlider: UIControl {
    
    @IBInspectable public var upperRange: CGFloat {
        get{ return renderer.upperRange}
        set{
            if(newValue>lowerRange){
                renderer.upperRange = newValue
            }
        }
    }
    @IBInspectable public var lowerRange: CGFloat {
        get{ return renderer.lowerRange}
        set{
            if(newValue<upperRange){
                renderer.lowerRange = newValue
            }
        }
    }
    /*
     @IBInspectable var trackTintColor: UIColor = UIColor(white: 0.9, alpha: 1.0) {
     get { return renderer. }
     set { renderer.color = newValue }
     }
     */
    @IBInspectable public var middleColor: UIColor{
        get{ return renderer.middleColor}
        set{renderer.middleColor = newValue}
    }
    @IBInspectable public var upperColor: UIColor{
        get{ return renderer.upperColor}
        set{renderer.upperColor = newValue}
    }
    @IBInspectable public var lowerColor: UIColor{
        get{ return renderer.lowerColor}
        set{renderer.lowerColor = newValue}
    }
    
    public var thumbTintColor: UIColor{
        get{ return renderer.thumbTintColor}
        set{renderer.thumbTintColor = newValue}
    }
    
    public var curvaceousness: CGFloat{
        get{ return renderer.curvaceousness}
        set{renderer.curvaceousness = newValue}
    }
    
    public var minimumValue: Double{
        get { return renderer.minimumValue }
        set { renderer.minimumValue = newValue }
    }
    
    public var maximumValue: Double{
        get { return renderer.maximumValue }
        set { renderer.maximumValue = newValue }
    }
    
    public var sliderValue: Double{
        get { return renderer.sliderValue }
        set { renderer.sliderValue = newValue
            
        }
    }
    
    public var sliderdelegate: VerticalSliderDelegate?
    let renderer = SliderRenderer()
    var previousLocation = CGPoint()
    
    public func setSliderValue(_ newValue: Double, animated: Bool = false) {
        sliderValue = min(maximumValue, max(minimumValue, newValue))
        print(sliderValue)
    }
    
    private func commonInit() {
        renderer.updateBounds(self.bounds)
        self.middleColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.95, alpha: 1.0)
        self.upperColor = UIColor(hue: 0.1, saturation: 0.5, brightness: 0.95, alpha: 1.0)
        self.lowerColor = UIColor(hue: 0.6, saturation: 0.5, brightness: 0.95, alpha: 1.0)
        layer.addSublayer(renderer.trackLayer)
        layer.addSublayer(renderer.thumbLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

extension VerticalSlider {
    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        print("previous=\(previousLocation)")
        // Hit test the thumb layers
        if renderer.thumbLayer.thumbFrame.contains(previousLocation) {
            renderer.thumbLayer.highlighted = true
        }
        return renderer.thumbLayer.highlighted
    }
    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        // 1. Determine by how much the user has dragged
        let deltaLocation = Double(-location.y + previousLocation.y)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(renderer.trackLayer.trackHeight)
        previousLocation = location
        // 2. Update the values
        if renderer.thumbLayer.highlighted {
            sliderValue += deltaValue
            sliderValue = boundValue(value: sliderValue, toLowerValue: minimumValue, upperValue: maximumValue)
        }
        sendActions(for: .valueChanged)
        return true
    }
    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        renderer.thumbLayer.highlighted = false
        
        if(sliderValue>Double(self.upperRange)){
            sliderdelegate?.setToUpperRange(sliderValue)
        }else if(sliderValue<Double(self.lowerRange)){
            sliderdelegate?.setToLowerRange(sliderValue)
        }else{
            sliderdelegate?.setToMiddleRange(sliderValue)
        }
    }
}

extension VerticalSlider {
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        renderer.updateBounds(self.bounds)
    }
}
