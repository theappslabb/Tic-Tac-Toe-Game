//
//  PlayerSelectionVC.swift
//  Tic Tac Toe
//
//  Created by Gurjit Singh Ghangura on 2016-07-21.
//  Copyright © 2016 Gurjit Singh Ghangura. All rights reserved.
//

import UIKit

class PlayerSelectionVC: UIViewController {
    @IBOutlet weak var userNameTxtField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func setUserNameForGame(sender: UIButton) {
        if userNameTxtField.text == "" {
            let alert = UIAlertView.init(title: "ALert", message: "Enter Name", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        } else {
            BaseObject.sharedInstance.userName = userNameTxtField.text
        }
        
    }
    @IBAction func onePlayer(sender: UIButton) {
        BaseObject.sharedInstance.isComputerPlaying = true
        let gameView = self.storyboard?.instantiateViewControllerWithIdentifier("gameView");
        self.navigationController?.pushViewController(gameView!, animated: true)
    }
    @IBAction func twoPlayer(sender: UIButton) {
        BaseObject.sharedInstance.isComputerPlaying = false
        let gameView = self.storyboard?.instantiateViewControllerWithIdentifier("gameView");
        self.navigationController?.pushViewController(gameView!, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
