//
//  BubbleSettings.swift
//  UTS-iOS-BubblePop
//
//  Created by user164045 on 6/28/20.
//  Copyright © 2020 user164045. All rights reserved.
//

import Foundation
import UIKit

// Settings to define bubble color and settings


class BubbleSettings {
    let color: UIColor
   // let name: String
    let scores: Int

    
    init(color: UIColor, scores: Int) {
        self.color = color
        self.scores = scores
       // self.name = name
    }
}
