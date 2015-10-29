//
//  ViewController.swift
//  FitHubb
//
//  Created by Steven Huynh on 10/26/15.
//  Copyright © 2015 Steven Huynh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var Map: MKMapView!
    
    
    let coreLocationManager = CLLocationManager()
    
    let locationManager = LocationManager.sharedInstance
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.Map.delegate = self
        
        let authorizationCode = CLLocationManager.authorizationStatus()
        
        if authorizationCode == CLAuthorizationStatus.NotDetermined && coreLocationManager.respondsToSelector("requestAlwaysAuthorization") || coreLocationManager.respondsToSelector("requestWhenInUseAuthoriztion") {
            if NSBundle.mainBundle().objectForInfoDictionaryKey("NSLocationAlwaysUsageDescription") != nil {
                coreLocationManager.requestAlwaysAuthorization()
            } else {
                print("No description provided")
            }
        } else {
            Map.showsUserLocation = true
        }
    }
    
    @IBAction func UpdateLocationButtonPressed(sender: UIButton) {
        Map.showsUserLocation = true
        getLocation()
        
    }
    
    func getLocation() {
        locationManager.startUpdatingLocationWithCompletionHandler { (latitude, longitude, status, verboseMessage, error) -> () in
            self.displayLocation(CLLocation(latitude: (self.coreLocationManager.location?.coordinate.latitude)!, longitude: (self.coreLocationManager.location?.coordinate.longitude)!))
        }
    }
    
    func displayLocation(location: CLLocation){
        Map.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(self.Map.userLocation.coordinate.latitude, self.Map.userLocation.coordinate.longitude), span: MKCoordinateSpanMake(0.08, 0.08)), animated: true)
        
        locationManager.reverseGeocodeLocationUsingGoogleWithCoordinates(location) { (reverseGecodeInfo, placemark, error) -> Void in
            print(reverseGecodeInfo!)
        }
        Map.showsUserLocation = true
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            return nil
        }
        
        // Below condition is for custom annotation
        if (annotation.isKindOfClass(CustomAnnotation)) {
            let customAnnotation = annotation as? CustomAnnotation
            mapView.setTranslatesAutoresizingMaskIntoConstraints(false)
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("CustomAnnotation") as MKAnnotationView!
            
            if (annotationView == nil) {
                annotationView = customAnnotation?.annotationView()
            } else {
                annotationView.annotation = annotation;
            }
            
            self.addBounceAnimationToView(annotationView)
            return annotationView
        } else {
            return nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
