//
//  GateGreetingViewController.swift
//  Beacon Demo
//
//  Created by ME-Tech Mac User 1 on 12/26/15.
//  Copyright © 2015 Me-tech. All rights reserved.
//

import UIKit

class GateGreetingViewController: UIViewController {

    //green
    var major = 24330
    var minor = 2117
    var identifier = "Baggage Claim"
    
    @IBOutlet weak var closeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        closeBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeBtnPressed(sender: AnyObject) {
        var views = self.presentingViewController
        
        while ((views?.presentingViewController) != nil){
            views = views?.presentingViewController
        }
        
        views?.dismissViewControllerAnimated(true, completion: nil)
        
        let parameter: [String:AnyObject] = ["major" : major, "minor" : minor, "identifier" : identifier]
        NSNotificationCenter.defaultCenter().postNotificationName("reloadRegion", object: nil, userInfo: parameter)
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
