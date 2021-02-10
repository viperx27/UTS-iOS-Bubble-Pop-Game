//
//  Bubble.swift
//  UTS-iOS-BubblePop
//
//  Created by user164045 on 6/28/20.
//  Copyright © 2020 user164045. All rights reserved.
//

import UIKit
import GameKit
import CoreFoundation

class Bubble: UIButton {
    
  
    var temp: Int = 0
    var value = 0
    var bubbleButton:BubbleSettings?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        // adding values for bubble
        if self.backgroundColor == UIColor.red
        {
            self.value = 1
        }
        else if self.backgroundColor == UIColor.systemPink
        {
            self.value = 2
        }
        else if self.backgroundColor == UIColor.green
        {
            self.value = 5
        }
        else if self.backgroundColor == UIColor.blue
        {
            self.value = 8
        }
        else if self.backgroundColor == UIColor.black
        {
            self.value = 10
        }
        
        // getting bubble radius
        self.layer.cornerRadius = 0.5 * frame.width
        
    }
    
    // important method to use
    required init?(coder: NSCoder)
    {
       
        super.init(coder: coder)
        self.backgroundColor = UIColor.blue
        self.layer.cornerRadius = 0.5 * frame.width
    }
    
    //func bubbleAnimationFunc(){
    //let animateBubbleSpring = CASpringAnimation(keyPath: "transform.scale")
    //animateBubbleSpring.duration = 0.4
    //animateBubbleSpring.fromValue = 1
    //animateBubbleSpring.toValue = 0.6
   //// animateBubbleSpring.repeatCount = 1
   // animateBubbleSpring.initialVelocity = 0.6
   // animateBubbleSpring.damping = 1
   // layer.add(animateBubbleSpring, forKey: nil)
    //}
    
    func bubblefade() {
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2.0
        animation.repeatCount = 2.0
        self.layer.add(animation, forKey: nil)
    }
     
   
     
  



    
   
}
