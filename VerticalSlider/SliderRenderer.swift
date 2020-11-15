// Created 2020/11/11
// Using Swift 5.0

import Foundation
import UIKit

class SliderRenderer {
    
    //let trackLayer = CAShapeLayer()
    //let thumbLayer = CAShapeLayer()
    //var verticalSlider = VerticalSlider()
    let trackLayer = VerticalSliderTrackLayer()
    let thumbLayer = VerticalSliderThumbLayer()
    
    var upperColor: UIColor = .red {
        didSet {
            updateTrackLayerPath()
            //trackLayer.strokeColor = upperColor.cgColor
        }
    }
    var middleColor: UIColor = .green {
        didSet {
            updateTrackLayerPath()
            //trackLayer.strokeColor = middleColor.cgColor
        }
    }
    var lowerColor: UIColor = .blue {
        didSet {
            updateTrackLayerPath()
            //trackLayer.strokeColor = lowerColor.cgColor
        }
    }
    var thumbTintColor: UIColor = .white {
        didSet {
            updateThumbLayerPath()
        }
    }
    var curvaceousness: CGFloat = 0.5{
        didSet {
            updateThumbLayerPath()
        }
    }
    
    var upperRange: CGFloat = 0.9 {
        didSet {
            updateTrackLayerPath()
        }
    }
    var lowerRange: CGFloat = 0.1 {
        didSet {
            updateTrackLayerPath()
        }
    }
    
    var minimumValue: Double = 0.0 {
        didSet {
            updateTrackLayerPath()
        }
    }
    var maximumValue: Double = 1.0 {
        didSet {
            updateTrackLayerPath()
        }
    }
    var sliderValue: Double = 0.5 {
        didSet {
            updateThumbLayerPath()
        }
    }
    
    private func updateTrackLayerPath() {
        trackLayer.setNeedsDisplay()
    }
    private func updateThumbLayerPath() {
        thumbLayer.setNeedsDisplay()
    }

    func updateBounds(_ bounds: CGRect) {
        print("bounds=\(bounds)")
      trackLayer.bounds = bounds
      trackLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
      updateTrackLayerPath()
      thumbLayer.bounds = trackLayer.bounds
      thumbLayer.position = trackLayer.position
      updateThumbLayerPath()
    }
    init(){
        thumbLayer.verticalSliderRenderer = self
        thumbLayer.contentsScale = UIScreen.main.scale
        trackLayer.verticalSliderRenderer = self
        trackLayer.contentsScale = UIScreen.main.scale
        //trackLayer = verticalSlider.trackLayer
        //thumbLayer = verticalSlider.thumbLayer
    }
}
/*
class KnobRenderer {
  var color: UIColor = .blue {
    didSet {
      trackLayer.strokeColor = color.cgColor
      pointerLayer.strokeColor = color.cgColor
    }
  }
  var lineWidth: CGFloat = 4 {
    didSet {
      trackLayer.lineWidth = lineWidth
      pointerLayer.lineWidth = lineWidth
      updateTrackLayerPath()
      updatePointerLayerPath()
    }
  }
  var pointerLength: CGFloat = 6 {
    didSet {
      updateTrackLayerPath()
      updatePointerLayerPath()
    }
  }
  
  var startAngle: CGFloat = CGFloat(-Double.pi) * 11 / 8 {
    didSet {
      updateTrackLayerPath()
    }
  }
  var endAngle: CGFloat = CGFloat(Double.pi) * 3 / 8 {
    didSet {
      updateTrackLayerPath()
    }
  }
  
  private (set) var pointerAngle: CGFloat = CGFloat(-Double.pi) * 11 / 8
  let trackLayer = CAShapeLayer()
  let pointerLayer = CAShapeLayer()
  
  func setPointerAngle(_ newPointerAngle: CGFloat, animated: Bool = false) {
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    pointerLayer.transform = CATransform3DMakeRotation(newPointerAngle, 0, 0, 1)
    if animated {
      let midAngleValue = (max(newPointerAngle, pointerAngle) - min(newPointerAngle, pointerAngle)) / 2 + min(newPointerAngle, pointerAngle)
      let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
      animation.values = [pointerAngle, midAngleValue, newPointerAngle]
      animation.keyTimes = [0.0, 0.5, 1.0]
        animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)]
      pointerLayer.add(animation, forKey: nil)
    }
    CATransaction.commit()
    pointerAngle = newPointerAngle
  }
  
  private func updateTrackLayerPath() {
    let bounds = trackLayer.bounds
    let center = CGPoint(x: bounds.midX, y: bounds.midY)
    let offset = max(pointerLength, lineWidth  / 2)
    let radius = min(bounds.width, bounds.height) / 2 - offset
    
    let ring = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    trackLayer.path = ring.cgPath
  }
  
  private func updatePointerLayerPath() {
    let bounds = trackLayer.bounds
    let pointer = UIBezierPath()
    let center = CGPoint(x: bounds.midX, y: bounds.midY)
    let offset = max(pointerLength, lineWidth  / 2)
    let radius = min(bounds.width, bounds.height) / 2 - offset
    
    let startingpoint = CGPoint(x: center.x + radius + CGFloat(pointerLength) + CGFloat(lineWidth)/2, y: bounds.midY)
    //let startingpoint = CGPoint(x: bounds.width - CGFloat(pointerLength) - CGFloat(lineWidth) / 2, y: bounds.midY)
    pointer.move(to: startingpoint)
    pointer.addLine(to: CGPoint(x: center.x + radius, y: bounds.midY))
    pointerLayer.path = pointer.cgPath
  }
  
  func updateBounds(_ bounds: CGRect) {
    trackLayer.bounds = bounds
    trackLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    updateTrackLayerPath()
    pointerLayer.bounds = trackLayer.bounds
    pointerLayer.position = trackLayer.position
    updateThumbLayerPath()
  }

  init() {
    trackLayer.fillColor = UIColor.clear.cgColor
    pointerLayer.fillColor = UIColor.clear.cgColor
  }
}
*/
