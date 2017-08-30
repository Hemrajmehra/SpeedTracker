//
//  ViewController.swift
//  SpeedLocator
//
//  Created by nisha rani on 17/06/17.
//  Copyright © 2017 nisha rani. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    var last:CLLocation?
    var locationManager: CLLocationManager = CLLocationManager()
    var locViewModel: DataViewModel!
    var last_speed = 0.0
    var current_speed = 0.0
    var trackingStatus = false
    var tracking_data = ""
    var BtnOnOff:String = ""

    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var BtnStart: UIButton!
    @IBOutlet weak var BtnStop: UIButton!
    @IBOutlet weak var SpeedTrackValue: UIButton!
  //  @IBOutlet weak var MapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BtnStop.backgroundColor = UIColor.lightGray
        BtnStart.backgroundColor = UIColor.lightGray
        
        BtnStop.layer.cornerRadius = 0.5 * BtnStop.bounds.size.width
        BtnStop.clipsToBounds = true
        
        BtnStart.layer.cornerRadius = 0.5 * BtnStop.bounds.size.width
        BtnStart.clipsToBounds = true
        
        SpeedTrackValue.layer.cornerRadius = 0.5 * SpeedTrackValue.bounds.size.width
        SpeedTrackValue.clipsToBounds = true
        
        setLocationManager()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveSartClick(_ sender: Any) {
    BtnOnOff = "On"
        BtnStop.backgroundColor = UIColor.lightGray
        BtnStart.backgroundColor = UIColor.black
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            }
        } else {
            showAlert(message: "Location services are not enabled.\n Goto settings > privacy > location")
        }
    }
    
    @IBAction func saveStopClick(_ sender: Any) {
        BtnStop.backgroundColor = UIColor.black
        BtnStart.backgroundColor = UIColor.lightGray

        BtnOnOff = "Off"
          tracking_data = ""
        
    }
     @IBAction func saveLocationClick(_ sender: Any) {
        
        print(BtnOnOff as Any)
        if BtnOnOff == "Off" {
            showAlert(message: "Please Start to track and save location.")
            return
        }
        
        if tracking_data != "" {
            locViewModel.saveDataInDatabase(tracking_data: tracking_data)
            locViewModel.saveDataToFile(tracking_data: tracking_data)
            showAlert(message: "Saved successfuly")
        }else {
            showAlert(message: "Please wait!")
        }
        
    }
    
}

//MARK: - OTHER FNCTION
extension ViewController {
    //function to show alert message
    func showAlert(message msg: String) {
        let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //function to set location manager
    func setLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //function to stop timer
    func invalidateTimer() {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        if appdelegate.timer != nil {
            appdelegate.timer?.invalidate()
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if BtnOnOff == "Off" {
            invalidateTimer()
            current_speed = CLLocationSpeed()
            current_speed = locationManager.location!.speed
            lblSpeed.text = String(format: "%.0f", current_speed * 3.6)
            last_speed = 0.0
            current_speed = 0.0
            return
        }
        last_speed = current_speed
        current_speed = CLLocationSpeed()
        current_speed = locationManager.location!.speed
        lblSpeed.text = String(format: "%.0f", current_speed * 3.6)
        let lat = String(format: "%.2f",(locations.last?.coordinate.latitude)!)
        let longi = String(format: "%.2f",(locations.last?.coordinate.longitude)!)
       // print("lat",lat)
        //print("longi",longi)
        
        if last_speed != current_speed {
            invalidateTimer()
            trackingStatus = false
        }else if last_speed == current_speed {
            
            trackingStatus = true
        }
        locViewModel = DataViewModel(latitude: Double(lat)!, longitude: Double(longi)!, speed: Double(lblSpeed.text!)!, lastSpeed: last_speed)
        if trackingStatus == false {
            locViewModel.getLocationUpdate { (dataTracking) in
                print(dataTracking.currentTimeInterval)
                print(dataTracking.nextTimeInterval)
                let strDate = self.locViewModel.getTime()
                self.tracking_data = "\(strDate) \(dataTracking.latitude) \(dataTracking.longitude) \(dataTracking.currentTimeInterval) \(dataTracking.nextTimeInterval)"
                print("self.tracking_data",self.tracking_data)
                
                
            }
        }
    }
}

