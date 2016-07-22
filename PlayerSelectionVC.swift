//
//  PlayerSelectionVC.swift
//  Tic Tac Toe
//
//  Created by Gurjit Singh Ghangura on 2016-07-21.
//  Copyright © 2016 Gurjit Singh Ghangura. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class PlayerSelectionVC: UIViewController, UIActionSheetDelegate {
    @IBOutlet weak var userNameTxtField: UITextField!
    
    var userData : NSMutableDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()
        //var facebookProfileUrl = "http://graph.facebook.com/\(userID)/picture?type=large"
        // Do any additional setup after loading the view.
    }

    @IBAction func facebookLogin(sender: UIButton) {
        
        BaseObject.sharedInstance.isComputerPlaying = false
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Use Profile Picture Instead of", message: "", preferredStyle: .ActionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelActionButton)
        
        let saveActionButton: UIAlertAction = UIAlertAction(title: "Cross", style: .Default)
        { action -> Void in
            BaseObject.sharedInstance.customImage = true
            BaseObject.sharedInstance.isCircle = false
            self.facebook()
        }
        actionSheetController.addAction(saveActionButton)
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: "Circle", style: .Default)
        { action -> Void in
            BaseObject.sharedInstance.customImage = true
            BaseObject.sharedInstance.isCircle = true
            self.facebook()
        }
        actionSheetController.addAction(deleteActionButton)
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    
        
    }
    
    func facebook() -> Void {
        let loginManager = FBSDKLoginManager();
        loginManager.loginBehavior = FBSDKLoginBehavior.Browser
        FBSDKLoginManager().logInWithReadPermissions(["public_profile", "email"],fromViewController:self ,handler: { (result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
            if error != nil {
                print("error")
            }else if(result.isCancelled){
                print("result cancelled")
            }else{
                let fbRequest = FBSDKGraphRequest(graphPath:"me", parameters: nil);
                fbRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
                    
                    if error == nil {
                        BaseObject.sharedInstance.userData = result as! NSMutableDictionary
                        let finishedUrl = BaseObject.sharedInstance.url.stringByReplacingOccurrencesOfString("userID", withString: "\(BaseObject.sharedInstance.userData.valueForKey("id")!)")
                        let data = NSData(contentsOfURL: NSURL(string: finishedUrl)!)
                        BaseObject.sharedInstance.image = UIImage(data: data!)
                        self.pushViewController()
                    } else {
                        
                    }
                }
            }
        })
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
    }
    @IBAction func twoPlayer(sender: UIButton) {
        BaseObject.sharedInstance.isComputerPlaying = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pushViewController() -> Void {
        let gameView = self.storyboard?.instantiateViewControllerWithIdentifier("gameView");
        self.navigationController?.pushViewController(gameView!, animated: true)
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
