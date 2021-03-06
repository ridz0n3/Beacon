//
//  CheckInMapViewController.swift
//  Beacon Demo
//
//  Created by ME-Tech Mac User 1 on 12/22/15.
//  Copyright © 2015 Me-tech. All rights reserved.
//

import UIKit

class CheckInMapViewController: UIViewController, ESTBeaconManagerDelegate {
    
    var beaconManager = ESTBeaconManager()
    var region = CLBeaconRegion()
    
    //green
    var major : CLBeaconMajorValue = 24330
    var minor : CLBeaconMinorValue = 2117
    var identifier = "Check in"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        beaconManager = ESTBeaconManager()
        beaconManager.delegate = self
        beaconManager.requestAlwaysAuthorization()
        region = CLBeaconRegion(proximityUUID: estimote_uuid!, major: major, minor: minor, identifier: identifier)
        
        beaconManager.startRangingBeaconsInRegion(region)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: estimote delegate
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        if beacons.count != 0{
            
            if beacons[0].accuracy < 2 && beacons[0].accuracy > 0{
                print(beacons[0].accuracy)
                
                let checkInVC = self.storyboard?.instantiateViewControllerWithIdentifier("CheckInVC") as! CheckInViewController
                self.presentViewController(checkInVC, animated: true, completion: nil)
                beaconManager.stopRangingBeaconsInRegion(region)
                
            }
            
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
