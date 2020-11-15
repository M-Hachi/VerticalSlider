// Created 2020/11/12
// Using Swift 5.0

import UIKit

class VerticalSliderTrackLayer: CALayer {
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
    
    var trackWidth: CGFloat {
        return CGFloat(bounds.width/4)
    }
    var trackHeight: CGFloat {
        return CGFloat(bounds.height*0.9)
    }
    override func draw(in ctx: CGContext) {
        //print("draw track")
        if let renderer = verticalSliderRenderer {
            //print("draw track is set")
            print("track bounds = \(self.bounds)")
            
            let trackCenter = CGPoint(x: bounds.width/2 ,y: bounds.height/2)
            let trackFrame = CGRect(x: trackCenter.x-trackWidth/2, y: trackCenter.y-trackHeight/2, width: trackWidth, height: trackHeight)
            print("track frame = \(trackFrame)")
            let cornerRadius = trackFrame.width * renderer.curvaceousness / 2.0
            
           
            // fill middle track
            ctx.setFillColor(renderer.middleColor.cgColor)
            ctx.fill(trackFrame)
            
            // fill the upper range
            let upperRange = renderer.upperRange
            //let upperFrame = CGRect(x: trackCenter.x-trackWidth*0.5, y: (upperRange-0.5)*trackHeight+trackCenter.y, width: trackWidth, height: trackHeight*(1-upperRange) )
            let upperFrame = CGRect(x: trackCenter.x-trackWidth/2, y: trackCenter.y-trackHeight/2, width: trackWidth, height: trackHeight*(1-upperRange) )
            ctx.setFillColor(renderer.upperColor.cgColor)
            //let upperRect = CGRect(x: 0.0, y: upperRange*trackHeight/2+trackCenter.y, width: trackWidth, height: trackHeight*(1-upperRange) )
            ctx.fill(upperFrame)
            
            // fill the lower range
            ctx.setFillColor(renderer.lowerColor.cgColor)
            let lowerRange = renderer.lowerRange
            let lowerRect = CGRect(x: 0.0, y: 0.0, width: bounds.width, height: lowerRange*bounds.height)
            let lowerFrame = CGRect(x: trackCenter.x-trackWidth*0.5, y: trackHeight/2+trackCenter.y-trackHeight*lowerRange, width: trackWidth, height: trackHeight*lowerRange )
            ctx.fill(lowerFrame)
            
            
            // mask layer
            let path = UIBezierPath(roundedRect: trackFrame, cornerRadius: cornerRadius)
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.mask = mask
            
            // Fill - with a subtle shadow
            let shadowColor = UIColor.gray
            // Outline
            ctx.setShadow(offset: CGSize(width: 0.0, height: 1.0), blur: 4.0, color: shadowColor.cgColor)
            ctx.setStrokeColor(shadowColor.cgColor)
            ctx.setLineWidth(2)
            ctx.addPath(path.cgPath)
            ctx.strokePath()
        }
    }
    /*override func draw(in ctx: CGContext) {
     print("draw track")
     if let slider = verticalSlider {
     // Clip
     let cornerRadius = bounds.height * slider.curvaceousness / 2.0
     let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
     ctx.addPath(path.cgPath)
     
     // fill track
     ctx.setFillColor(slider.middleColor.cgColor)
     ctx.addPath(path.cgPath)
     ctx.fillPath()
     // fill the upper range
     ctx.setFillColor(slider.upperColor.cgColor)
     let upperRange = slider.upperRange
     let upperRect = CGRect(x: 0.0, y: upperRange, width: bounds.width, height: bounds.height-upperRange)
     ctx.fill(upperRect)
     // fill the lower range
     ctx.setFillColor(slider.lowerColor.cgColor)
     let lowerRange = slider.lowerRange
     let lowerRect = CGRect(x: 0.0, y: 0.0, width: bounds.width, height: lowerRange)
     ctx.fill(lowerRect)
     
     /* Fill the highlighted range
     ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
     let lowerValuePosition = CGFloat(slider.positionForValue(value: slider.lowerValue))
     let upperValuePosition = CGFloat(slider.positionForValue(value: slider.upperValue))
     let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
     ctx.fill(rect)*/
     }
     }*/
    
}
/*
class VerticalSliderTrackFrameLayer: CALayer {
    weak var verticalSliderRenderer: SliderRenderer?{
        didSet{
            print("vertical slider set")
        }
    }
    let tracklayer: VerticalSliderTrackLayer?
    var trackWidth: CGFloat {
        return CGFloat(bounds.width/4)
    }
    var trackHeight: CGFloat {
        return CGFloat(bounds.height*0.9)
    }
    override func draw(in ctx: CGContext) {
        //print("draw track")
        if let track = tracklayer {
            track.mask =
            //print("draw track is set")
            print("track bounds = \(self.bounds)")
            
            let trackCenter = CGPoint(x: bounds.width/2 ,y: bounds.height/2)
            let trackFrame = CGRect(x: trackCenter.x-trackWidth/2, y: trackCenter.y-trackHeight/2, width: trackWidth, height: trackHeight)
            print("track frame = \(trackFrame)")
            
            ctx.addCurve(to: <#T##CGPoint#>, control1: <#T##CGPoint#>, control2: <#T##CGPoint#>)
            
            // fill the upper range
            let upperRange = renderer.upperRange
            //let upperFrame = CGRect(x: trackCenter.x-trackWidth*0.5, y: (upperRange-0.5)*trackHeight+trackCenter.y, width: trackWidth, height: trackHeight*(1-upperRange) )
            let upperFrame = CGRect(x: trackCenter.x-trackWidth/2, y: trackCenter.y-trackHeight/2, width: trackWidth, height: trackHeight*(1-upperRange) )
            ctx.setFillColor(renderer.upperColor.cgColor)
            //let upperRect = CGRect(x: 0.0, y: upperRange*trackHeight/2+trackCenter.y, width: trackWidth, height: trackHeight*(1-upperRange) )
            ctx.fill(upperFrame)
            
            // fill the lower range
            ctx.setFillColor(renderer.lowerColor.cgColor)
            let lowerRange = renderer.lowerRange
            let lowerRect = CGRect(x: 0.0, y: 0.0, width: bounds.width, height: lowerRange*bounds.height)
            let lowerFrame = CGRect(x: trackCenter.x-trackWidth*0.5, y: trackHeight/2+trackCenter.y-trackHeight*lowerRange, width: trackWidth, height: trackHeight*lowerRange )
            ctx.fill(lowerFrame)
            
            let cornerRadius = trackFrame.width * renderer.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: trackFrame, cornerRadius: cornerRadius)
            ctx.addPath(path.cgPath)
            
            // fill track
            ctx.setFillColor(renderer.middleColor.cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()
        }
    }
}*/
