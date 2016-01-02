//
//  BaggageCollectionViewController.swift
//  Beacon Demo
//
//  Created by ME-Tech Mac User 1 on 12/26/15.
//  Copyright © 2015 Me-tech. All rights reserved.
//

import UIKit

class BaggageCollectionViewController: UIViewController {

    @IBOutlet weak var navigateBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigateBtn.layer.cornerRadius = 10
        let logo = UIImage(named: "header")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func navigateBtnPressed(sender: AnyObject) {
        let baggageNavigateVC = self.storyboard?.instantiateViewControllerWithIdentifier("BaggageMapVC")
        
        self.navigationController?.pushViewController(baggageNavigateVC!, animated: true)
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
