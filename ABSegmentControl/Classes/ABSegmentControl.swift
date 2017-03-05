//
//  ABSegmentControl.swift
//  TestPlacesAPI
//
//  Created by alexanderbollbach on 3/3/17.
//  Copyright © 2017 alexanderbollbach. All rights reserved.
//

import UIKit

protocol ABSegmentControlDelegate {
   
   
}

class ABSegmentControl: UIView {

   var delegate: ABSegmentControlDelegate?
   var segments = [ABSegment]()
   
   var activeSegmentLine = CAShapeLayer()
      

   var widthOfSegment: CGFloat!
   

   
   var activeSegment = ABSegment()
   
   func addSegment(segment: String) {
      let newSegment = ABSegment(title: segment)
      segments.append(newSegment)
      
      newSegment.backgroundColor = .blue
      
      addSubview(newSegment)
      
      newSegment.delegate = self
   }
   
   
   func configure(withSegments segments: [String]) {
      
      if segments.count < 1 {
         fatalError("needs atleast one segment")
      }
      
      for segmentString in segments {
         addSegment(segment: segmentString)
      }
      
      layoutSubviews()
      
      
      guard let activeSegment = self.segments.first else {
         fatalError("couldn't set active segment")
      }
      
      
      // preset initial state using delegate
      didTap(segment: activeSegment)
      
      
   }
   
   required init?(coder aDecoder: NSCoder) {
      
      super.init(coder: aDecoder)
      
      
      
      setup()
      
   }
   
   func setup() {
      
      activeSegmentLine.fillColor = UIColor.yellow.cgColor
      layer.addSublayer(activeSegmentLine)

   }
   
   override func layoutSubviews() {
      
      super.layoutSubviews()
      
      activeSegmentLine.frame = CGRect(x: 0, y: frame.size.height * 0.8,
                                       width: frame.size.width,
                                       height: frame.size.height * 0.2)

      let fullWidth = bounds.width
      
      let heightOfSegment = bounds.height * 0.8
      
      
      let widthOfSegment = fullWidth / CGFloat(segments.count)
      
      self.widthOfSegment = widthOfSegment
      
      
      var xOrigin: CGFloat = 0
      
      for segment in self.segments {
         let segFrame = CGRect(x: xOrigin,
                               y: 0,
                               width: widthOfSegment,
                               height: heightOfSegment)
         segment.frame = segFrame
         xOrigin += widthOfSegment
      }
      
      
      activeSegmentLine.path = UIBezierPath(rect: CGRect(x: 0,
                                                         y: 0,
                                                         width: activeSegmentLine.frame.size.width,
                                                         height: activeSegmentLine.frame.size.height)).cgPath
      
   }
   
   
   
   
   
   
   func animateActiveSegmentLine(fromPrev prev: ABSegment, toCurr curr: ABSegment) {

      
      // use segment bounds to position active-line underneath
      var boundsP = prev.frame
      var boundsC = curr.frame
      
      // shrink height to bottom 20%
      boundsP.size.height = self.bounds.size.height * 0.2
      boundsC.size.height = self.bounds.size.height * 0.2
      
      // one transition frame for now
      var bounds_transition1 = boundsP
      
//      bounds_transition1.size.height /= 2
//      bounds_transition1.origin.y += bounds_transition1.size.height / 2 - bounds_transition1.size.height / 2
      
      
      let forwards = boundsP.origin.x < boundsC.origin.x
      
      if forwards {
         
         // width expands to its current size plus number of segment-width's its covering
         bounds_transition1.size.width += (boundsC.origin.x - boundsP.origin.x)
      } else {
         
         bounds_transition1.size.width += (boundsP.origin.x - boundsC.origin.x)
         
         // in backgrounds case origin needs to slide back in addition to width expanding
         bounds_transition1.origin.x = boundsC.origin.x
         
      }
      let path1 = UIBezierPath(rect: boundsP).cgPath
      let path2 = UIBezierPath(rect: bounds_transition1).cgPath
      let path3 = UIBezierPath(rect: boundsC).cgPath
      

      let anim = CAKeyframeAnimation(keyPath: "path")
      anim.duration = 0.25
//      anim.isCumulative = true
      
      anim.values = [path1,path2,path3]
      anim.keyTimes = [0.1, 0.8, 1]
      anim.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
      anim.isRemovedOnCompletion = false
      anim.fillMode = kCAFillModeForwards
      
      let anim2 = CAKeyframeAnimation(keyPath: "opacity")
      anim2.duration = 0.25

      
      anim2.values = [1.0, 0.7, 1.0]
      anim2.keyTimes = [0, 0.5, 1]
      anim2.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
//      anim2.isRemovedOnCompletion = true
//      anim2.fillMode = kCAFillModeForwards
      
      
      anim.beginTime = 0
      anim2.beginTime = 0.1
//
//      
      activeSegmentLine.add(anim, forKey: "")
      activeSegmentLine.add(anim2, forKey: "")
      
      
      

   }


}



extension ABSegmentControl: ABSegmentProtocol {
   
   func didTap(segment: ABSegment) {
      
      let prev = activeSegment
      
      activeSegment = segment
      
      let curr = activeSegment
      
      animateActiveSegmentLine(fromPrev: prev, toCurr: curr)
   }
   
   
}
