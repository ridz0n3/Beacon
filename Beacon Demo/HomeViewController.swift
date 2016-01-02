//
//  HomeViewController.swift
//  Beacon Demo
//
//  Created by ME-Tech Mac User 1 on 12/22/15.
//  Copyright © 2015 Me-tech. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, ESTBeaconManagerDelegate, CBPeripheralManagerDelegate {
    
    var beaconManager = ESTBeaconManager()
    var region = CLBeaconRegion()
    
    //purple
    var major : CLBeaconMajorValue = 17407
    var minor : CLBeaconMinorValue = 28559
    var identifier = "time left"
    
    var bluetoothPeripheralManager: CBPeripheralManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "header")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        //On viewDidLoad/didFinishLaunchingWithOptions
        let options = [CBCentralManagerOptionShowPowerAlertKey:0] //<-this is the magic bit!
        bluetoothPeripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: options)
        
        beaconManager = ESTBeaconManager()
        beaconManager.delegate = self
        beaconManager.requestAlwaysAuthorization()
        region = CLBeaconRegion(proximityUUID: estimote_uuid!, major: major, minor: minor, identifier: identifier)//purple
        
        //beaconManager.stopMonitoringForRegion(region)
        beaconManager.startRangingBeaconsInRegion(region)
        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshRegion:", name: "reloadRegion", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshRegion(sender: NSNotification){
        let info = sender.userInfo as! [String:AnyObject]
        
        major = CLBeaconMajorValue((info["major"]?.integerValue)!)
        minor = CLBeaconMinorValue((info["minor"]?.integerValue)!)
        identifier = info["identifier"] as! String
        
        region = CLBeaconRegion(proximityUUID: estimote_uuid!, major: major, minor: minor, identifier: identifier)
        beaconManager.startRangingBeaconsInRegion(region)
    }
    
    func beaconManager(manager: AnyObject, didEnterRegion region: CLBeaconRegion) {
        
        if region.major == 17407{
            
            let notification = UILocalNotification()
            notification.alertTitle = "Notification"
            notification.alertBody = "Welcome to KLIA"
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            
        }
    }
    
    func beaconManager(manager: AnyObject, didExitRegion region: CLBeaconRegion) {
        print("exit: \(region)")
    }
    
    func beaconManager(manager: AnyObject, didStartMonitoringForRegion region: CLBeaconRegion) {
        print("enter: \(region)")
    }
    
    //MARK: estimote delegate
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        if beacons.count != 0{
            
            if beacons[0].accuracy < 2 && beacons[0].accuracy > 0{
                print(beacons[0].accuracy)
                
                if beacons[0].major == 17407{
                    
                    if region.identifier == "Upsell"{
                    }else{
                        let checkInVC = self.storyboard?.instantiateViewControllerWithIdentifier("boardingVC") as! ViewController
                        self.navigationController?.presentViewController(checkInVC, animated: true, completion: nil)
                        beaconManager.stopRangingBeaconsInRegion(region)
                    }
                    
                }else if beacons[0].major == 24330{
                    
                    if region.identifier == "Baggage Claim"{
                        let checkInVC = self.storyboard?.instantiateViewControllerWithIdentifier("BaggageVC") as! BaggageCollectionViewController
                        self.navigationController?.presentViewController(checkInVC, animated: true, completion: nil)
                        beaconManager.stopRangingBeaconsInRegion(region)
                    }else{
                        let checkInVC = self.storyboard?.instantiateViewControllerWithIdentifier("CheckInVC") as! CheckInViewController
                        self.navigationController?.presentViewController(checkInVC, animated: true, completion: nil)
                        beaconManager.stopRangingBeaconsInRegion(region)
                    }
                    
                }else if beacons[0].major == 2820{
                    
                    if region.identifier == "Boarding Gate"{
                        let checkInVC = self.storyboard?.instantiateViewControllerWithIdentifier("GateVC") as! GateGreetingViewController
                        self.navigationController?.presentViewController(checkInVC, animated: true, completion: nil)
                        beaconManager.stopRangingBeaconsInRegion(region)
                    }else if region.identifier == "Baggage Gate"{
                        let checkInVC = self.storyboard?.instantiateViewControllerWithIdentifier("BaggageGateVC") as! BaggageGateViewController
                        self.presentViewController(checkInVC, animated: true, completion: nil)
                        beaconManager.stopRangingBeaconsInRegion(region)
                    }else{
                        let checkInVC = self.storyboard?.instantiateViewControllerWithIdentifier("BoardingGateVC") as! BoardingGateViewController
                        self.navigationController?.presentViewController(checkInVC, animated: true, completion: nil)
                        beaconManager.stopRangingBeaconsInRegion(region)
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func beaconManager(manager: AnyObject, rangingBeaconsDidFailForRegion region: CLBeaconRegion?, withError error: NSError) {
        print(error.localizedDescription)
    }
    //MARK: bluetooth delegate
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        
        if peripheral.state == CBPeripheralManagerState.PoweredOff {
            
            // create the alert
            let alert = UIAlertController(title: "Turn On Bluetooth to Allow to Connect Accessories", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Setting", style: UIAlertActionStyle.Default, handler: { action in
                // do something like...
                UIApplication.sharedApplication().openURL(NSURL(string:"prefs:root=Bluetooth")!)
                
            }))
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            // show the alert
            self.presentViewController(alert, animated: true, completion: nil)
            
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
