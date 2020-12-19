// Created 2020/11/12
// Using Swift 5.0

import UIKit

class VerticalSliderThumbLayer: CALayer {
    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }

    weak var verticalSlider: VerticalSlider?{
        didSet{
            print("vertical slider set")
        }
    }
    weak var verticalSliderRenderer: SliderRenderer?{
        didSet{
            print("vertical slider set")
        }
    }
    
    var thumbWidth: CGFloat {
        return CGFloat(bounds.width*0.8)
    }
    var thumbHeight: CGFloat {
        return thumbWidth/3
    }
    
    var trackHeight: CGFloat {
        return CGFloat(bounds.height*0.9)
    }
    
    func deltaPositionForValue(value: Double) -> CGFloat {
        return CGFloat(value/(verticalSliderRenderer!.maximumValue-verticalSliderRenderer!.minimumValue)*Double(self.trackHeight))
    }
    var thumbCenter:CGPoint=CGPoint(x: 0, y: 0)
    var thumbFrame: CGRect{
        return CGRect(x: thumbCenter.x-thumbWidth/2, y: thumbCenter.y-thumbHeight/2, width: thumbWidth, height: thumbHeight)
    }
    override func draw(in ctx: CGContext) {
        if let renderer = verticalSliderRenderer {
            //print("thumb bounds = \(self.bounds)")
            let yval :CGFloat = deltaPositionForValue(value: (0.5-renderer.sliderValue)) + self.bounds.height/2
            thumbCenter = CGPoint(x: bounds.width*0.5, y: yval)
            let cornerRadius = thumbFrame.height * renderer.curvaceousness / 2.0
            let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
            
            // Fill - with a subtle shadow
            let shadowColor = UIColor.gray
            ctx.setShadow(offset: CGSize(width: 0.0, height: 1.0), blur: 4.0, color: shadowColor.cgColor)
            ctx.setFillColor(renderer.thumbTintColor.cgColor)
            ctx.addPath(thumbPath.cgPath)
            ctx.fillPath()

            // Outline
            ctx.setStrokeColor(shadowColor.cgColor)
            ctx.setLineWidth(0.5)
            ctx.addPath(thumbPath.cgPath)
            ctx.strokePath()

            if highlighted {
                ctx.setFillColor(UIColor(white: 0.7, alpha: 0.5).cgColor)
                ctx.addPath(thumbPath.cgPath)
                ctx.fillPath()
            }
        }
    }
    /*override func draw(in ctx: CGContext) {
        print("draw thumb")
        if let slider = verticalSlider {
            print("draw isset")
            let thumbFrame = bounds.insetBy(dx: 2.0, dy: 2.0)
            let cornerRadius = thumbFrame.height * slider.curvaceousness / 2.0
            let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
            
            // Fill - with a subtle shadow
            let shadowColor = UIColor.gray
            ctx.setShadow(offset: CGSize(width: 0.0, height: 1.0), blur: 1.0, color: shadowColor.cgColor)
            ctx.setFillColor(slider.thumbTintColor.cgColor)
            ctx.addPath(thumbPath.cgPath)
            ctx.fillPath()

            // Outline
            ctx.setStrokeColor(shadowColor.cgColor)
            ctx.setLineWidth(0.5)
            ctx.addPath(thumbPath.cgPath)
            ctx.strokePath()

            if highlighted {
                ctx.setFillColor(UIColor(white: 0.0, alpha: 0.1).cgColor)
                ctx.addPath(thumbPath.cgPath)
                ctx.fillPath()
            }
        }else{
            print("RangeSliderThumbLayer: rangeSlider nil")
        }
    }*/

}
