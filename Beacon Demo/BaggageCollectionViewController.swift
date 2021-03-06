//
//  BaggageCollectionViewController.swift
//  Beacon Demo
//
//  Created by ME-Tech Mac User 1 on 12/26/15.
//  Copyright © 2015 Me-tech. All rights reserved.
//

import UIKit

class BaggageCollectionViewController: UIViewController {

    var major = 2820
    var minor = 40462
    var identifier = "Baggage Gate"
    
    @IBOutlet weak var navigateBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigateBtn.layer.cornerRadius = 10
        closeBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func navigateBtnPressed(sender: AnyObject) {
        let baggageNavigateVC = self.storyboard?.instantiateViewControllerWithIdentifier("BaggageMapVC") as! BaggageMapViewController
        self.presentViewController(baggageNavigateVC, animated: true, completion: nil)
    }

    @IBAction func closeBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
