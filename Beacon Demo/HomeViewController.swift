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
    var region1 = CLBeaconRegion()
    var region2 = CLBeaconRegion()
    var region3 = CLBeaconRegion()
    var region4 = CLBeaconRegion()
    //Define class variable in your VC/AppDelegate
    @IBOutlet var greetingView: UIView!
    
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
        //region = CLBeaconRegion(proximityUUID: estimote_uuid!, identifier: "region")
        region1 = CLBeaconRegion(proximityUUID: estimote_uuid!, major: 17407, minor: 28559, identifier: "monitor")//purple
        region2 = CLBeaconRegion(proximityUUID: estimote_uuid!, major: 24330, minor: 2117, identifier: "monitor2")//blue
        region3 = CLBeaconRegion(proximityUUID: estimote_uuid!, major: 2820, minor: 40462, identifier: "monitor3")//green
        region4 = CLBeaconRegion(proximityUUID: virtual_uuid!, major: 2793, minor: 19481, identifier: "monitor4")//virtual
        
        //beaconManager.startRangingBeaconsInRegion(region)
        beaconManager.startMonitoringForRegion(region1)
        beaconManager.startMonitoringForRegion(region2)
        beaconManager.startMonitoringForRegion(region3)
        beaconManager.startMonitoringForRegion(region4)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beaconManager(manager: AnyObject, didEnterRegion region: CLBeaconRegion) {
        
        if region.major == 2793{
            
            let notification = UILocalNotification()
            notification.alertTitle = "Notification"
            notification.alertBody = "Welcome to KLIA"
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            
            beaconManager.startRangingBeaconsInRegion(region4)
            //let deptTime = self.storyboard?.instantiateViewControllerWithIdentifier("boardingVC") as! ViewController
            //self.navigationController?.pushViewController(deptTime, animated: true)
            
            /*greetingView = NSBundle.mainBundle().loadNibNamed("GreetingViewController", owner: self, options: nil)[0] as! UIView
            
            greetingView.frame = CGRectMake(0 , 0, self.view.frame.size.width, 100)
            greetingView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25)
            //navigateBtn.layer.cornerRadius = 10;
            let applicationLoadViewIn = CATransition()
            applicationLoadViewIn.type = kCATransitionFade
            applicationLoadViewIn.duration = 2.0
            applicationLoadViewIn.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            greetingView.layer.addAnimation(applicationLoadViewIn, forKey: kCATransitionReveal)
            self.view.addSubview(greetingView)*/
            
        }
        /*let notification = UILocalNotification()
        notification.alertTitle = ""
        notification.alertBody = "Welcome to KLIA"
        notification.soundName = UILocalNotificationDefaultSoundName
        //notification.applicationIconBadgeNumber = 1
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)*/
    }
    
    func beaconManager(manager: AnyObject, didExitRegion region: CLBeaconRegion) {
        print(region)
    }
    
    func beaconManager(manager: AnyObject, didStartMonitoringForRegion region: CLBeaconRegion) {
        print(region)
    }
    
    //MARK: estimote delegate
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        if beacons[0].accuracy >= 0.3{
            print("0.3 above")
        }else if beacons[0].accuracy <= 0.2{
            print("0.2 below")
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
