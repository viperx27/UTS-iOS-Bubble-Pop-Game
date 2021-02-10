//
//  GameSceneController.swift
//  UTS-iOS-BubblePop
//
//  Created by user164045 on 6/28/20.
//  Copyright © 2020 user164045. All rights reserved.
//

import UIKit
import GameKit
import CoreFoundation
import Foundation


// Help has been taken from the Internet

class GameSceneController: UIViewController {
    @IBOutlet weak var leaderboardlabel: UILabel!
    @IBOutlet weak var scorelabel: UILabel!
    @IBOutlet weak var stackcover: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var countDown: UILabel!
  
    
    let gameKit: GKARC4RandomSource = GKARC4RandomSource()
    var timer: Int = 60
    var inheritedSettings: BubbleSettings?
    var colorTint: Int = 1
    var colorHue: Int = 1
    var points: Int = 0
    var highScore: Int = 0
    var initialscore: Int = 0
    let temp: Int = 0
    var maxTimer: Int = 60
    let delete: Int = 3
    var maxBub: Int = 15
    var numberColour = Int()
    var mixedrandm: Int?
    var bubbles: [BubbleSettings] = []
    var initialColor = "red"
    var lasrColor = "black"
    var Username = "Tester"
    
    var leftTimer: Int = 0


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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "exitsegue" {
            let hit = segue.destination as! ScoreViewController
            hit.username = self.Username
            hit.lastscore = self.points
        }
    }
    
    
    
    func initStage() {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true)
            { (timer) in
            self.timer -= 1
                self.timerLabel.text = String(self.timer)
              
            if self.timer <= 0
            {
            timer.invalidate()
            self.leftTimer = 1
            self.exit()
            }
                self.randompop()
                self.bubbleAddFame()
                
            }
    }
    
    
    func leadScore() {
        do {
            var leaderboard = try Database().leadRecords()
            leaderboard.sort(by: { $0.score > $1.score })
            highScore = leaderboard[0].score
           leaderboardlabel.text = String(highScore)
        } catch
        {
         highScore = 0
        }
    }
    
    
    
    

    func stageCounter() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                if let initializer = Int(self.countDown.text ?? "0") {
                    if initializer == 1 {
                    timer.invalidate()
                        self.countDown.isHidden = true
                    self.initStage()
                }
                else {
                        UIView.transition(with: self.countDown, duration: 0.1, options: .transitionCrossDissolve, animations: {
                    self.countDown.text = String(initializer - 1)
                        })
                    }
                }
            })
    }
    
   
       func bubbleAddFame() {
             if addNumbBubble() < maxBub
             {
                 let minBub = gameKit.nextInt(upperBound: (maxBub - addNumbBubble()))
                 for _ in 0...minBub
                 {
                     let AxisX = CGFloat(self.gameKit.nextUniform()) * (self.stackcover.frame.width-100)
                     let AxisY = CGFloat(self.gameKit.nextUniform()) * (self.stackcover.frame.height-100)
                     let curBub = Bubble(frame: CGRect(x: AxisX, y: AxisY, width: 70, height: 70))
                     curBub.bubbleButton = bubbleprobs()
                     adjustBubbleColor(of: curBub)
                     curBub.addTarget(self, action: #selector(self.addonescore), for: UIControl.Event.touchUpInside)
                     let locality = checkLocation(of: curBub)
                         if locality
                         {
                             curBub.tag = searchFlag();
                             self.stackcover.addSubview(curBub)
                             self.stackcover.sendSubviewToBack(curBub)
                            }
                    
                         curBub.transform = CGAffineTransform(scaleX: 0, y: 0)
                            
                    UIView.animate(withDuration: 0.2, animations:
                                {
                                 curBub.transform = CGAffineTransform.identity
                             })
                 }
             }
         }
       

    override func viewDidAppear(_ animation: Bool)
    {
        super.viewDidAppear(animation)
    
    }
    
    
    override func viewWillDisappear(_ animation: Bool) {
      
        if let score = self.scorelabel.text
        {
            if let scoreNum = Int(score),
                
                let userName = self.navigationItem.title{
                
              
                let userDefaults = UserDefaults.standard
                userDefaults.set(scoreNum, forKey: "score")
                userDefaults.set(userName, forKey: "name")
                
                
            }
            
        }
    }
    
   // check if location exists
    func checkLocation(of newBubble: Bubble) -> Bool {
        for subview in self.stackcover.subviews {
            if let isBubble = subview as? Bubble {
                if isBubble.frame.intersects(newBubble.frame) {
                    return false
                }
            }
        }
        return true
    }
    

    
   // setting probablity to randomize the bubbles
    func bubbleprobs() -> BubbleSettings {
        var bubbleprob: [BubbleSettings] = []
        for _ in 1...40 {
            bubbleprob.append(bubbles[0])
        }
        for _ in 1...30 {
            bubbleprob.append(bubbles[1])
        }
        for _ in 1...15 {
            bubbleprob.append(bubbles[2])
        }
        for _ in 1...10 {
            bubbleprob.append(bubbles[3])
        }
        for _ in 1...5 {
            bubbleprob.append(bubbles[4])
        }
        let selection: Int = gameKit.nextInt(upperBound: bubbleprob.count)
        return bubbleprob[selection]
    }
    

        func addNumbBubble() -> Int {
        var count: Int = 0
        for subview in self.stackcover.subviews {
            if subview is Bubble {
                count += 1
            }
        }
        return count
    }
    
   
    
   //On touch bubble action
    @IBAction func addonescore(_ sender: Bubble) {
        let value = combobubbleValue(from: sender.bubbleButton!)
        
        self.points += value
        scorelabel.text = String(self.points)
        leadScore()
                         
       //shrink
        UIView.animate(withDuration: 0.1, animations: {
        sender.transform = CGAffineTransform(scaleX: 0.07, y: 0.07)
        }) { (_) in
        sender.removeFromSuperview()
        }
    }
    
  
    func randompop() {
        guard maxTimer % delete == 0 else {
            
            return
        
            
           }
           var removedBubbleCount = gameKit.nextInt(upperBound: addNumbBubble())
           for subview in self.stackcover.subviews
           {
               if subview.tag > 0
               {
                   if removedBubbleCount > 0
                   {
                       bubbleDeletion(subview as! Bubble)
                       removedBubbleCount -= 1
                   }
                   else {
                       break
                   }
               }
           }
       }
    
   // bubble color settings method
    func adjustBubbleColor(of currBubble: Bubble)
    {
        if let bubColor = currBubble.bubbleButton?.color
        {
            switch bubColor {
            case UIColor.red:
                currBubble.backgroundColor = UIColor.red
            case UIColor.systemPink:
                currBubble.backgroundColor = UIColor.systemPink
            case UIColor.green:
                currBubble.backgroundColor = UIColor.green
            case UIColor.blue:
                currBubble.backgroundColor = UIColor.blue
            case UIColor.black:
                currBubble.backgroundColor = UIColor.black
            default:
                break
            }
        }
    }
    
    // adding the bubble score point
    func combobubbleValue(from tempposition: BubbleSettings) -> Int
    {
        if inheritedSettings?.color == tempposition.color
        {
            let scores = 1.5 * Double(tempposition.scores)
    
            return Int(round(scores))
        }
        else
        {
            inheritedSettings = tempposition
           
            return tempposition.scores
        }
    }

    // Removing the bubble from superview
    func bubbleDeletion(_ sender: Bubble)
    {
      if let availableBubble = self.stackcover.viewWithTag(sender.tag)
      {
               
               // Animate fading bubble
      UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn,
            animations: {
            availableBubble.alpha = 0.02
               }) { (_) in
                   sender.removeFromSuperview()
               }
           }
       }
    // To check if it collides with other bubble
     func searchFlag() -> Int
     {
              
      while true {
            let gametag = gameKit.nextInt(upperBound: 50) + 1
            guard let _ = self.stackcover.viewWithTag(gametag) else {
            return gametag
                  }
              }
          }
    
    func exit()
    {
        if self.leftTimer == 1 {
            self.performSegue(withIdentifier: "exitsegue", sender: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leadScore()
        stageCounter()
        hidekeyboard()
        self.timerLabel.text = String(timer)
        bubbles.append(BubbleSettings(color: .red, scores: 1));
        bubbles.append(BubbleSettings(color: .systemPink, scores: 2));
        bubbles.append(BubbleSettings(color: .green, scores: 5));
        bubbles.append(BubbleSettings(color: .blue, scores: 8));
        bubbles.append(BubbleSettings(color: .black, scores: 10));
       
        
    }
    
    
    
    
}
