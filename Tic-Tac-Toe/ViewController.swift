//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Scott on 2/3/16.
//  Copyright © 2016 Canderis Productions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topLeft: UIImageView!
    @IBOutlet weak var topCenter: UIImageView!
    @IBOutlet weak var topRight: UIImageView!
    
    @IBOutlet weak var centerLeft: UIImageView!
    @IBOutlet weak var centerCenter: UIImageView!
    @IBOutlet weak var centerRight: UIImageView!
    
    @IBOutlet weak var bottomLeft: UIImageView!
    @IBOutlet weak var bottomCenter: UIImageView!
    @IBOutlet weak var bottomRight: UIImageView!
    
    @IBOutlet weak var winLossCtr: UILabel!
    
    var state = 1
    var turnCount = 0
    
    var scoring = [
        "col1": 0,
        "col2": 0,
        "col3": 0,
        
        "row1": 0,
        "row2": 0,
        "row3": 0,
        
        "diag1": 0,
        "diag2": 0,
    ]
    
    var xWins = 0
    var oWins = 0
    var totalGames = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabel()
        
        topLeft.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "topLeftTapped:"))
        topCenter.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "topCenterTapped:"))
        topRight.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "topRightTapped:"))
        
        centerLeft.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "centerLeftTapped:"))
        centerCenter.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "centerCenterTapped:"))
        centerRight.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "centerRightTapped:"))
        
        bottomLeft.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "bottomLeftTapped:"))
        bottomCenter.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "bottomCenterTapped:"))
        bottomRight.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "bottomRightTapped:"))
        
    }
    
    func topLeftTapped(gesture: UIGestureRecognizer){
        scoring["row1"] = scoring["row1"]! + state
        scoring["col1"] = scoring["col1"]! + state
        scoring["diag1"] = scoring["diag1"]! + state
        
        imageTapped(gesture)
    }
    
    func topCenterTapped(gesture: UIGestureRecognizer){
        scoring["row1"] = scoring["row1"]! + state
        scoring["col2"] = scoring["col2"]! + state

        imageTapped(gesture)
    }

    func topRightTapped(gesture: UIGestureRecognizer){
        scoring["row1"] = scoring["row1"]! + state
        scoring["col3"] = scoring["col3"]! + state
        scoring["diag2"] = scoring["diag2"]! + state
        
        imageTapped(gesture)
    }

    
    func centerLeftTapped(gesture: UIGestureRecognizer){
        scoring["row2"] = scoring["row2"]! + state
        scoring["col1"] = scoring["col1"]! + state

        imageTapped(gesture)
    }

    func centerCenterTapped(gesture: UIGestureRecognizer){
        scoring["row2"] = scoring["row2"]! + state
        scoring["col2"] = scoring["col2"]! + state
        scoring["diag1"] = scoring["diag1"]! + state
        scoring["diag2"] = scoring["diag2"]! + state
        
        imageTapped(gesture)
    }

    func centerRightTapped(gesture: UIGestureRecognizer){
        scoring["row2"] = scoring["row2"]! + state
        scoring["col3"] = scoring["col3"]! + state
        
        imageTapped(gesture)
    }

    
    func bottomLeftTapped(gesture: UIGestureRecognizer){
        scoring["row3"] = scoring["row3"]! + state
        scoring["col1"] = scoring["col1"]! + state
        scoring["diag2"] = scoring["diag2"]! + state
        
        imageTapped(gesture)
    }

    func bottomCenterTapped(gesture: UIGestureRecognizer){
        scoring["row3"] = scoring["row3"]! + state
        scoring["col2"] = scoring["col2"]! + state

        imageTapped(gesture)
    }

    func bottomRightTapped(gesture: UIGestureRecognizer){
        scoring["row3"] = scoring["row3"]! + state
        scoring["col3"] = scoring["col3"]! + state
        scoring["diag1"] = scoring["diag1"]! + state
        
        imageTapped(gesture)
    }

    
    func imageTapped(gesture: UIGestureRecognizer) {
        //print(gesture)
        if let imageView = gesture.view as? UIImageView {
            if(state==1){
                imageView.image = UIImage(named: "x_image")
            }else{
                imageView.image = UIImage(named: "o_image")
            }
            imageView.userInteractionEnabled = false
            state = state * -1
            turnCount++
            if(turnCount >= 3){
                checkThreeInARow()
            }
            
        }
    }
    
    func checkThreeInARow(){
        if(turnCount >= 9){
            //print("tie")
            totalGames++
            updateLabel()
            resetBoard()
            return
        }
        for (_,row) in scoring{
            if(row == 3){
                //print("X Wins")
                xWins++; totalGames++
                //updateLabel()
                resetBoard()
                updateLabel()
                return
            }
            if(row == -3){
                //print("o wins")
                oWins++; totalGames++
                
                resetBoard()
                updateLabel()
                return
            }
        }
    }
    
    func updateLabel(){
        let plainText = "X's Wins: \(xWins)\t O's Wins: \(oWins)\t Total Games: \(totalGames)"
        
        let styledText = NSMutableAttributedString(string: plainText)
        let attributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(winLossCtr.font.pointSize)
        ]
        var nameRange = (plainText as NSString).rangeOfString("X's Wins:")
        styledText.setAttributes(attributes, range: nameRange)
        nameRange = (plainText as NSString).rangeOfString("Total Games:")
        styledText.setAttributes(attributes, range: nameRange)
        nameRange = (plainText as NSString).rangeOfString("O's Wins:")
        styledText.setAttributes(attributes, range: nameRange)

        
        winLossCtr.attributedText = styledText
    }
    
    func resetBoard(){
        topLeft.image = UIImage(named: "blank")
        topLeft.userInteractionEnabled = true
        
        topCenter.image = UIImage(named: "blank")
        topCenter.userInteractionEnabled = true
        
        topRight.image = UIImage(named: "blank")
        topRight.userInteractionEnabled = true
        
        
        centerLeft.image = UIImage(named: "blank")
        centerLeft.userInteractionEnabled = true
        
        centerCenter.image = UIImage(named: "blank")
        centerCenter.userInteractionEnabled = true
        
        centerRight.image = UIImage(named: "blank")
        centerRight.userInteractionEnabled = true
        
        
        bottomLeft.image = UIImage(named: "blank")
        bottomLeft.userInteractionEnabled = true
        
        bottomCenter.image = UIImage(named: "blank")
        bottomCenter.userInteractionEnabled = true
        
        bottomRight.image = UIImage(named: "blank")
        bottomRight.userInteractionEnabled = true
        
        state = 1
        turnCount = 0
        
        scoring = [
            "col1": 0,
            "col2": 0,
            "col3": 0,
            
            "row1": 0,
            "row2": 0,
            "row3": 0,
            
            "diag1": 0,
            "diag2": 0,
        ]

    }
    
}

