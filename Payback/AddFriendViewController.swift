//
//  AddFriendViewController.swift
//  Payback
//
//  Created by Labuser on 3/6/16.
//  Copyright © 2016 Kelly Stathis. All rights reserved.
//

import UIKit

class AddFriendViewController: UITableViewController {
    @IBOutlet weak var searchBar: UITextField!

    //To do (storyboard):
    //1. New DOne button addexpense
    //2. change vie controller identity to Add Friend Vei Controller
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPress(sender: AnyObject){
        
        for user in HomePageViewController.userList {
            if user.name == searchBar.text {
                showPopUp("User already exists!")
                return
            }
        }
        if searchBar.text! == HomePageViewController.userOfApp.name {
            showPopUp("User already exists!")
            return
        }
        
        if (searchBar.text != nil && searchBar.text != "") {
            let newUser:User = User(id: -1, name: searchBar.text!)
            HomePageViewController.userList.append(newUser)
        }
    }
    
    
    func showPopUp(message : String){
        
        let alert = UIAlertController(title: "Info Missing", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default)
            {
                (UIAlertAction) -> Void in
        }
        alert.addAction(alertAction)
        presentViewController(alert, animated: true)
            {
                () -> Void in
        }
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
