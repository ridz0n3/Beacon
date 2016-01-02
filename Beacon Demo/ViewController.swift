//
//  ViewController.swift
//  Beacon Demo
//
//  Created by ME-Tech Mac User 1 on 12/9/15.
//  Copyright © 2015 Me-tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ESTBeaconManagerDelegate, CBPeripheralManagerDelegate {
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var minute: UILabel!
    @IBOutlet weak var boardingTime: UILabel!
    @IBOutlet weak var proceedBtn: UIButton!

    var beaconManager = ESTBeaconManager()
    var region = CLBeaconRegion()
    //Define class variable in your VC/AppDelegate
    var bluetoothPeripheralManager: CBPeripheralManager?
    
    let date1 = "2015-12-23 9:12:00 a.m."
    override func viewDidLoad() {
        super.viewDidLoad()
        
        proceedBtn.layer.cornerRadius = 10;
        let logo = UIImage(named: "header")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        let currentFormatter = NSDateFormatter();
        currentFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        currentFormatter.timeZone = NSTimeZone(abbreviation: "GMT+8:00")
        let date = currentFormatter.dateFromString(date1)
        date?.timeIntervalSinceNow
        let diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute], fromDate: date!)
        
        var min = String()
        var hour = String()
        if diffDateComponents.minute < 10{
            min = "0\(diffDateComponents.minute)"
        }else{
            min = "\(diffDateComponents.minute)"
        }
        
        if diffDateComponents.hour < 10{
            hour = "0\(diffDateComponents.hour)"
        }else{
            hour = "\(diffDateComponents.hour)"
        }
        boardingTime.text = "\(hour)\(min)"
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("countdown"), userInfo: nil, repeats: true)
        
        //On viewDidLoad/didFinishLaunchingWithOptions
        let options = [CBCentralManagerOptionShowPowerAlertKey:0] //<-this is the magic bit!
        bluetoothPeripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: options)
        
        beaconManager = ESTBeaconManager()
        beaconManager.delegate = self
        beaconManager.requestAlwaysAuthorization()
        //region = CLBeaconRegion(proximityUUID: estimote_uuid!, identifier: "region")
        region = CLBeaconRegion(proximityUUID: estimote_uuid!, major: 17407, minor: 28559, identifier: "monitor")

        //beaconManager.startRangingBeaconsInRegion(region)
        beaconManager.startMonitoringForRegion(region)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    func countdown() {
        let currentDate = NSDate();
        let currentFormatter = NSDateFormatter();
        currentFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        currentFormatter.timeZone = NSTimeZone(abbreviation: "GMT+8:00")
        let date = currentFormatter.dateFromString(date1)
        
        let diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute], fromDate: currentDate, toDate: date!, options: NSCalendarOptions.init(rawValue: 0))
        
        
        let countdown = "\(diffDateComponents.month) m: \(diffDateComponents.day) d: \(diffDateComponents.hour) h: \(diffDateComponents.minute) min"
        
        time.text = countdown
        minute.text = "\(diffDateComponents.minute)"

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beaconManager(manager: AnyObject, didEnterRegion region: CLBeaconRegion) {
        let notification = UILocalNotification()
        notification.alertTitle = ""
        notification.alertBody = "Welcome to KLIA"
        notification.soundName = UILocalNotificationDefaultSoundName
        //notification.applicationIconBadgeNumber = 1
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
    
    //MARK: estimote delegate
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        //let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        print(beacons[0])
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

    @IBAction func proceedBtnPressed(sender: AnyObject) {
        
        let homeVC = self.storyboard?.instantiateViewControllerWithIdentifier("CheckInMapVC") as! CheckInMapViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
        
    }
}

