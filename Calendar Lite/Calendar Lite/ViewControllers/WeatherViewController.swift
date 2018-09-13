//
//  SecondViewController.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/16/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var rawWeatherData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(location.latitude), \(location.longitude)")
        self.updateWeatherAtLocation(location)
        self.stopUpdatingLocation()
    }
    
    func updateWeatherAtLocation(_ location: CLLocationCoordinate2D){
        self.updateWeatherAtLocation(latitude: location.latitude.description, longitude: location.longitude.description)
    }

    func updateWeatherAtLocation(latitude:String, longitude:String) {
        
        //let geoCode:String = "37.8267,-122.4233"
        let geoCode: String = ("\(latitude),\(longitude)")
        
        WeatherAPI().currentWeatherAsync(geoCode:geoCode) { (result) in
            var responseString = ""
            switch result {
            case .success(let response):
                print("Current Weather:\n\(response)")
                responseString = response
            case .error(let error):
                print("Weather api failed, Error:\(error)")
                responseString = error.localizedDescription
            }
            
            DispatchQueue.main.async {
                self.rawWeatherData.text = responseString
            }
        }
    }
    
}

