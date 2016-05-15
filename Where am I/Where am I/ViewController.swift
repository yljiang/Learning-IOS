//
//  ViewController.swift
//  Where am I
//
//  Created by Flare on 2016-03-11.
//  Copyright © 2016 Flare. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    //MAIN: PARAMS
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    
    var manager :CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let location:CLLocation = locations[0]
        let lat: CLLocationDegrees = location.coordinate.latitude
        let long: CLLocationDegrees = location.coordinate.longitude
        let speed = location.speed
        longLabel.text = String(lat)
        latLabel.text = String(long)
        speedLabel.text = String(speed)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) -> Void in
            if error != nil {
                print(error)
                
            }else{
                if let p = placemarks?[0]{
                    
                    self.addressLabel.text = "\(p.thoroughfare!) \(p.subLocality!) \n \(p.subAdministrativeArea!) \n \(p.postalCode!)\n \(p.country!) "
                    print(p)
                }
            }
        }
        print(location)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

