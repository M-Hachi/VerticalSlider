// Created 2020/11/11
// Using Swift 5.0

import UIKit

@IBDesignable public class VerticalSlider: UIControl {
 
    @IBInspectable var upperRange: CGFloat {
        get{ return renderer.upperRange}
        set{renderer.upperRange = newValue}
    }
    @IBInspectable var lowerRange: CGFloat {
        get{ return renderer.lowerRange}
        set{renderer.lowerRange = newValue}
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
    
    let renderer = SliderRenderer()
    //let trackLayer = VerticalSliderTrackLayer()
    //let thumbLayer = VerticalSliderThumbLayer()
    public var sliderValue: Double{
        get { return renderer.sliderValue }
        set { renderer.sliderValue = newValue }
    }
    
    var previousLocation = CGPoint()
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    public func setSliderValue(_ newValue: Double, animated: Bool = false) {
        sliderValue = min(maximumValue, max(minimumValue, newValue))
        print(sliderValue)
        
    }
    private func commonInit() {
        renderer.updateBounds(self.bounds)
        //renderer.color = tintColor
        //renderer.setPointerAngle(renderer.startAngle, animated: false)
        
        self.middleColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.95, alpha: 1.0)
        self.upperColor = UIColor(hue: 0.1, saturation: 0.5, brightness: 0.95, alpha: 1.0)
        self.lowerColor = UIColor(hue: 0.6, saturation: 0.5, brightness: 0.95, alpha: 1.0)
        layer.addSublayer(renderer.trackLayer)
        layer.addSublayer(renderer.thumbLayer)
    }
    
    override init(frame: CGRect) {
        print("override")
        super.init(frame: frame)
        commonInit()
        /*
        self.renderer.verticalSlider = self
        /*trackLayer.verticalSlider = self
         trackLayer.contentsScale = UIScreen.main.scale
         layer.addSublayer(trackLayer)
         
         thumbLayer.rangeSlider = self
         thumbLayer.contentsScale = UIScreen.main.scale
         layer.addSublayer(thumbLayer)*/
        trackLayer.verticalSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        thumbLayer.verticalSlider = self
        thumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(thumbLayer)
        commonInit()*/
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}
extension VerticalSlider {
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        print("\(previousLocation)")
        // Hit test the thumb layers
        if renderer.thumbLayer.frame.contains(previousLocation) {
            renderer.thumbLayer.highlighted = true
        }
        return renderer.thumbLayer.highlighted
    }
    
    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }
    
    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        // 1. Determine by how much the user has dragged
        let deltaLocation = Double(-location.y + previousLocation.y)
        //let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.height)
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
        print("value = \(sliderValue)")
        renderer.thumbLayer.highlighted = false
    }
}

extension VerticalSlider {
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        renderer.updateBounds(self.bounds)
        //trackLayer.setNeedsDisplay()
        //thumbLayer.setNeedsDisplay()
    }
}
