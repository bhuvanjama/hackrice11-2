//
//  TextContacts.swift
//  PoliceRecorder
//
//  Created by Bhuvan Jama on 9/18/21.
//

import Foundation
import Firebase
import MessageUI
import MapKit
import CoreLocation

//class TextContacts {
struct TextContacts {
    
    let ref = Database.database().reference()
    let email = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")

    
    func sendText() {
        
        self.ref.child("Emergency-Contacts").child(email ?? "hello-gmail-com").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let phoneNumber = value?["phoneNumber"] as? Int

                       let sms: String = "sms:\(String(describing: phoneNumber))&body=\("I'm in trouble")"
                       let strURL: String = sms.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!
                       UIApplication.shared.open(URL.init(string: strURL)!,options: [:], completionHandler: nil)
            
            /*self.ref.child("Emergency-Contacts").child(self.email ?? "hello-gmail-com").child(snapshot.key).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let val = snapshot.value as? NSDictionary
                
                print("hello")
                
                if let phoneNumber = val?["phoneNumber"] as? Int {
                    var location: LocationManager = LocationManager()
                    let sms: String = "sms:\(String(describing: phoneNumber))&body=Hello, this is a message from Aura. I am currently not safe and am dealing with an assaulter/law enforcement. Audio files and video files will be available online in case something happens to me. My location is \(location.getCoords())."
                    let strURL: String = sms.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!
                    UIApplication.shared.open(URL.init(string: strURL)!,options: [:], completionHandler: nil)
                }
            })*/
        })
    }
}


class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    var location: CLLocation? = nil
    
    
    override init() {
        super.init()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        var currentLocation: CLLocation!
        currentLocation = locationManager.location
        
        
    }
    
    func getCoords() -> CLLocation {
        
        var currentLocation: CLLocation!
        currentLocation = locationManager.location
        
        let userCoordinate = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        
        return userCoordinate
        
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        self.location = location
    }
    
    
}
