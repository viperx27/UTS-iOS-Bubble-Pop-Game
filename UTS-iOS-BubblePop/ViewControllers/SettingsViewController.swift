//
//  SettingsViewController.swift
//  UTS-iOS-BubblePop
//
//  Created by user164045 on 6/28/20.
//  Copyright © 2020 user164045. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var bubbleSelector: UISlider!
    @IBOutlet weak var timeSlider: UISlider!
    
    @IBOutlet weak var mutableTimer: UILabel!
    @IBOutlet weak var mutableBubble: UILabel!
    @IBOutlet weak var playerNameTextField: UITextField!
    
    
    var maxtimer: Int = 60
    var maxbub: Int = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        hidekeyboard()
        playerNameTextField.delegate = self
    
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        
                      // let userDefaults = UserDefaults.standard
            
            //userDefaults.set(bubbleSelector, forKey: "maxtimer")
                 }
    

    @IBAction func timeSetting(_ sender: Any)
    {
        maxtimer = Int(timeSlider.value)
      mutableTimer.text = "\(maxtimer)"
    
       
    }
    
    @IBAction func bubblechanged(_ sender: Any)
    {
       maxbub = Int(bubbleSelector.value)
        mutableBubble.text = "\(maxbub)"
    }

    func hidekeyboard() {
                 
                  let tap: UITapGestureRecognizer = UITapGestureRecognizer(
                  target: self,
                  action: #selector(keytouch))
                 
                 view.addGestureRecognizer(tap)
                  }

                  @objc func keytouch()
                  {
                  
                  view.endEditing(true)
                  }
       
    
}
