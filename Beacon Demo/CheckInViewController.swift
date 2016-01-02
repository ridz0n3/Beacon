//
//  CheckInViewController.swift
//  Beacon Demo
//
//  Created by ME-Tech Mac User 1 on 12/22/15.
//  Copyright © 2015 Me-tech. All rights reserved.
//

import UIKit

class CheckInViewController: UIViewController {

    @IBOutlet var alertView: UIView!
    @IBOutlet weak var navigateBtn: UIButton!
    @IBOutlet weak var checkInBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkInBtn.layer.cornerRadius = 10;
        
        let logo = UIImage(named: "header")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkInBtnPressed(sender: AnyObject) {
        
        alertView = NSBundle.mainBundle().loadNibNamed("CheckInAlertView", owner: self, options: nil)[0] as! UIView
        
        alertView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        alertView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25)
        navigateBtn.layer.cornerRadius = 10;
        let applicationLoadViewIn = CATransition()
        applicationLoadViewIn.type = kCATransitionFade
        applicationLoadViewIn.duration = 2.0
        applicationLoadViewIn.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        alertView.layer.addAnimation(applicationLoadViewIn, forKey: kCATransitionReveal)
        self.view.addSubview(alertView)
        
    }

    @IBAction func closeAlertView(sender: AnyObject) {
        self.alertView.hidden = true
    }
    
    @IBAction func navigateBtnPressed(sender: AnyObject) {
        let gateNavigateVC = self.storyboard?.instantiateViewControllerWithIdentifier("GateNavigateVC")
        
        self.navigationController?.pushViewController(gateNavigateVC!, animated: true)
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
