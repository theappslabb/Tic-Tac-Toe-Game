//
//  Game.swift
//  Tic Tac Toe
//
//  Created by Gurjit Singh Ghangura on 2016-07-21.
//  Copyright © 2016 Gurjit Singh Ghangura. All rights reserved.
//

import UIKit

class Game: UIViewController {
    
    @IBOutlet weak var gameView: UIView!
    
    var userSteps = [0,0,0,0,0,0,0,0,0]
    
    let winnigArray = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8]]
    
    var now = 1;
    
    var winner = ""
    
    override func viewDidLoad() {
        userSteps = [0,0,0,0,0,0,0,0,0]
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func userPressed(sender: UIButton) {
        switchImage(sender)
    }
    
    func switchImage(button:UIButton) -> Void {
        let crossImage = UIImage(named: "Cross.png")
        if (userSteps[button.tag - 1] == 0) {
            if (now == 1) {
                button.setBackgroundImage(UIImage(named: "Circle.png"), forState: UIControlState.Normal)
                userSteps[button.tag - 1] = 1;
                now = 2
            } else {
                button.setBackgroundImage(crossImage, forState: UIControlState.Normal)
                userSteps[button.tag - 1] = 2;
                now = 1
            }
            if checkWinnig() {
                
            } else {
                if ((BaseObject.sharedInstance.isComputerPlaying) == true) {
                    self.performSelector(#selector(Game.ComputersTurn), withObject: nil, afterDelay: 2.0)
                } else {
                    checkWinnig()
                }
            }
        }
    }
    func checkWinnig() -> Bool {
        var gameOver = false
        for internalArray in winnigArray {
            let zero = internalArray[0];
            let first = internalArray[1];
            let second = internalArray[2];
            if (userSteps[zero] != 0 && userSteps[zero] == userSteps[first] && userSteps[first] == userSteps[second]) {
                if userSteps[zero] == 1 {
                    winner = "Circle"
                } else {
                    winner = "Cross"
                }
                let alert = UIAlertView.init(title: "Congrats", message: "\(winner) WON", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                gameOver = true
            }
        }
        return gameOver
    }
    func ComputersTurn() -> Void {
        var execute = false
        var randomNumber = Int(arc4random_uniform(8))
        while (execute == false) {
            if userSteps[randomNumber] == 0 {
                execute = true
            } else {
                randomNumber = Int(arc4random_uniform(8))
            }
        }
        let button = gameView.viewWithTag(randomNumber+1) as! UIButton
        if (now == 1) {
            button.setBackgroundImage(UIImage(named: "Circle.png"), forState: UIControlState.Normal)
            userSteps[randomNumber] = 1;
            now = 2
        } else {
            button.setBackgroundImage(UIImage(named: "Cross.png"), forState: UIControlState.Normal)
            userSteps[randomNumber] = 2;
            now = 1
        }
        
        checkWinnig()
    }
    func showRedLine() -> Void {
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
