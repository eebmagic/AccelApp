//
//  ViewController.swift
//  AccelApp
//
//  Created by Ethan Bolton on 8/26/19.
//  Copyright © 2019 Ethan Bolton. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    public var counter = 0
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var labeText: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    
    func clockString() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = (calendar.component(.hour, from: date) % 12)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
    
        let FULL:String = "\(hour):\(minute):\(second)"
        print(FULL)
        return(FULL)
    }
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
//        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        
        do {
            let defaults = UserDefaults.standard
            counter = (defaults.value(forKey: "lastCount") as? Int)!
            labeText.text = "\(counter)"
        } catch {
            counter = 0
        }
    }

    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        let alt = newLocation.altitude
        print("\(alt)")
        manager.stopUpdatingLocation()
    }
    
    func load() -> Int{
        let defaults = UserDefaults.standard
        let loadedCounter = defaults.value(forKey: "lastCount") as? Int
        return(loadedCounter!)
    }
    
    
    
    //MARK: Actions
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        labeText.text = "\(load())"
        counter += 1
        
        let defaults = UserDefaults.standard
        defaults.set(counter, forKey: "lastCount")
        
        print(load())
    }
    
    
    func startUpdate() {
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        
    }
    
    @objc func fire() -> Void{
        print("FIRE!")
        labeText.text = clockString()
    }
    
}

