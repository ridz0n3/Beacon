//
//  UpsellViewController.swift
//  Beacon Demo
//
//  Created by ME-Tech Mac User 1 on 1/3/16.
//  Copyright © 2016 Me-tech. All rights reserved.
//

import UIKit

class UpsellViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ESTBeaconManagerDelegate {
    
    @IBOutlet weak var upsellTableView: UITableView!
    @IBOutlet weak var sectionView: UIView!
    var beaconManager = ESTBeaconManager()
    var region = CLBeaconRegion()
    var upsellProduct = NSArray()
    var product = [String : AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        product = ["2820" : ["taxi","taxi","taxi"], "24330" : ["grocery","grocery","grocery","grocery"]]
        
        upsellTableView.backgroundColor = UIColor.lightGrayColor()
        beaconManager = ESTBeaconManager()
        beaconManager.delegate = self
        beaconManager.requestAlwaysAuthorization()
        region = CLBeaconRegion(proximityUUID: estimote_uuid!, identifier: "Upsell")
        
        beaconManager.startRangingBeaconsInRegion(region)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return upsellProduct.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = upsellTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomUpsellTableViewCell
        cell.roundedView.layer.cornerRadius = 10.0
        let beacon = upsellProduct[indexPath.row]
        //let cBeacon = beacon as! CLBeacon
        //cell.titleLbl.text = "\(beacon)"
        cell.upsellImg.image = UIImage(named: beacon as! String)
        return cell
    }
    
    var currentMajor = String()
    //MARK: estimote delegate
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        //upsellProduct = beacons
        let beaconArr = beacons as NSArray
        
        if beaconArr.count != 0{
            
            let cBeacon = beaconArr[0] as! CLBeacon
            if cBeacon.major != 17407{
                
                if currentMajor == "" || currentMajor != "\(cBeacon.major)"{
                    
                    upsellProduct = product["\(cBeacon.major)"] as! NSArray
                    upsellTableView.beginUpdates()
                    upsellTableView.deleteSections(NSIndexSet(index: 0), withRowAnimation: .Bottom)
                    upsellTableView.insertSections(NSIndexSet(index: 0), withRowAnimation: .Top)
                    upsellTableView.endUpdates()
                    currentMajor = "\(cBeacon.major)"
                    
                }
                
            }
        }
        //UITableViewRowAnimationRight
        /* UIView.transitionWithView(upsellTableView,
        duration:0.35,
        options:.TransitionCrossDissolve,
        animations:
        { () -> Void in
        self.upsellTableView.reloadData()
        },
        completion: nil);*/
        //upsellTableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 66
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        sectionView = NSBundle.mainBundle().loadNibNamed("SectionView", owner: self, options: nil)[0] as! UIView
        return sectionView
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
