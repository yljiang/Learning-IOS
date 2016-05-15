//
//  ViewController.swift
//  TicTacToe
//
//  Created by Flare on 2016-02-29.
//  Copyright © 2016 Flare. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MAIN:Parameters
    
    @IBOutlet weak var cell: UIButton!
    @IBOutlet weak var ggLabel: UILabel!
    
    var curPlayer = 1
    var occupied = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    let winningCombo = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
  
    var gameActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ggLabel.hidden = true
        ggLabel.center = CGPointMake(ggLabel.center.x - 500, ggLabel.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MAIN: Actions
    
    @IBAction func cellClick(sender: UIButton) {
        
        if occupied[sender.tag-1] == 0 && gameActive == true{
            occupied[sender.tag-1] = curPlayer
            
            if curPlayer == 1{
                sender.setImage(UIImage(named:"cross.png"), forState: .Normal)
                
                curPlayer = 2
            }
            else if curPlayer == 2{
                
                sender.setImage(UIImage(named:"nought.png"), forState: .Normal)
                curPlayer = 1
                
            }
            checkWin()
        }
        
       
    }
    @IBAction func reset(sender: AnyObject) {
        curPlayer = 1
        var btnToClear : UIButton

        for var i = 1; i <= 9; i++ {
            print(i)
            btnToClear = view.viewWithTag(i) as! UIButton
            btnToClear.setImage(nil, forState: .Normal)
            occupied[i-1] = 0
            
        }
        gameActive = true
        ggLabel.hidden = true
    }
    
    //Main: Helpers
    
    func checkWin(){
        print(occupied)
        
        for combo in winningCombo{
            if (occupied[combo[0]] != 0) && (occupied[combo[0]] == occupied[combo[1]] && occupied[combo[1]] == occupied[combo[2]]){
                
                if occupied[combo[0]] == 1{
                    ggLabel.text = "X has Won!"
                }
                else if occupied[combo[0]] == 2{
                    ggLabel.text = "O has Won!"
                }
                
                ggLabel.hidden = false
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                   self.ggLabel.center = CGPointMake(self.ggLabel.center.x + 500, self.ggLabel.center.y)
                })
                gameActive = false
            }
        }
        
        //check if there is a tie
        if !occupied.contains(0){
            ggLabel.text = "It's a tie!"
            
            
            ggLabel.hidden = false
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.ggLabel.center = CGPointMake(self.ggLabel.center.x + 500, self.ggLabel.center.y)
            })
            gameActive = false
        }
    }
   
}

