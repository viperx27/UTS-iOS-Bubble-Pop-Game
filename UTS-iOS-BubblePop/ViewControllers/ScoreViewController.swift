//
//  ScoreViewController.swift
//  UTS-iOS-BubblePop
//
//  Created by user164045 on 6/28/20.
//  Copyright © 2020 user164045. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var userScorelabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
   
 
    @IBOutlet weak var scoreTableView: UITableView!
    let base: Database = Database()
    var username: String?
    var lastscore: Int!
    var currentpoint: Int!
    let tableColumn: Int = 10
    let tableRows: Int = 10
   // var crush: [LeaderViewController] = []
    var hit: [LeaderViewController] = []
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()

        do {
            
            hit = try base.leadRecords()
            } catch
            {
           usernameLabel.text = "NoScores"
            }
               
        recordSorted()
        
               
        if let name = username  {
            usernameLabel.text = name
            userScorelabel.text = "\(lastscore!)"
            let viewScore = LeaderViewController(name: name, score: lastscore)
                   
      
            hit.append(viewScore)
            recordSorted()
            scoreTableView.reloadData()
                   
        
            do {
                try base.recordStorage(scores: hit)
            } catch {
                print("404 Error")
                }
                   
        }
            else {
                userScorelabel.text = ""
                usernameLabel.text = ""
               }
        
        scoreTableView.dataSource = self
        scoreTableView.delegate = self    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let box = tableView.dequeueReusableCell(withIdentifier: "ScoreStack", for: indexPath)
           let rows = indexPath.row
           
           // Get and display the labels the row cells
           let nameCell: UILabel = box.viewWithTag(1) as! UILabel
            //let currentScore: UILabel = box.viewWithTag(1) as! UILabel
           let scoreCell: UILabel = box.viewWithTag(2) as! UILabel
           
           nameCell.text = "\(rows + 1).  \(hit[rows].name)"
           // currentCell.text = "\(hit[indexpath.row].currentScore)"
           scoreCell.text = "------->  \(hit[indexPath.row].score)"
           
           return box
       }
       
     
    
       func recordSorted() {
           hit.sort(by: { $0.score > $1.score })
       }
       func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return min(hit.count, tableRows)
        }
    
       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }
  
    
    

}
