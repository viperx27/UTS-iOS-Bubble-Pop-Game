//
//  UserDataDisplay.swift
//  UTS-iOS-BubblePop
//
//  Created by user164045 on 6/28/20.
//  Copyright © 2020 user164045. All rights reserved.
//

import Foundation
import UIKit


class UserDataDisplay: Codable {
    
     func duplicate(_ Userinformation: UserDataDisplay)
     {
    takenname = Userinformation.takenname }
    
    private enum CodingKeys: String, CodingKey
    {case takenname}
    
    var onChanged: ((_ User: UserDataDisplay) -> Void)?
    
    var takenname = ""
    {
    didSet
    {
    onChanged?(self)
    }
    }
    init(name: String = "")
    {
        self.takenname = name
    }
    
}
