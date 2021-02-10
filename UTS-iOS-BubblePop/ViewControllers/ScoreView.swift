//
//  ScoreView.swift
//  UTS-iOS-BubblePop
//
//  Created by user164045 on 6/28/20.
//  Copyright © 2020 user164045. All rights reserved.
//

import Foundation
import UIKit

//oveerride score labels
class Score: UILabel
{
    
    
    //required coder and decoder
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) is not implemented")
    }
}
