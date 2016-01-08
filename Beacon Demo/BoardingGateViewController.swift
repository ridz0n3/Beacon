//
//  BoardingGateViewController.swift
//  Beacon Demo
//
//  Created by ME-Tech Mac User 1 on 1/2/16.
//  Copyright © 2016 Me-tech. All rights reserved.
//

import UIKit

class BoardingGateViewController: UIViewController {

    //green
    var major = 17407
    var minor = 28559
    var identifier = "Boarding Gate"
    
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
