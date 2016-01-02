//
//  BoardingMapViewController.swift
//  Beacon Demo
//
//  Created by ME-Tech Mac User 1 on 1/2/16.
//  Copyright © 2016 Me-tech. All rights reserved.
//

import UIKit

class BoardingMapViewController: UIViewController , ESTBeaconManagerDelegate {
    
    var beaconManager = ESTBeaconManager()
    var region = CLBeaconRegion()
    
    //green
    var major : CLBeaconMajorValue = 2820
    var minor : CLBeaconMinorValue = 40462
    var identifier = "gate"

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
                let checkInVC = self.storyboard?.instantiateViewControllerWithIdentifier("BoardingGateVC") as! GateGreetingViewController
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
