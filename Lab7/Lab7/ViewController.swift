//
//  ViewController.swift
//  Lab7
//
//  Created by Lucas Robertson on 5/20/18.
//  Copyright © 2018 lrober09. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import GeoFire
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var ref : DatabaseReference?
    var geoFire : GeoFire?
    var regionQuery : GFRegionQuery?
    let locationManager = CLLocationManager()
    let center = CLLocationCoordinate2D(latitude: 35.2832526, longitude: -120.5447026)
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLocationManager()
        ref = Database.database().reference().child("schools")
        geoFire = GeoFire(firebaseRef: Database.database().reference().child("GeoFire"))
        let span = MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.85)
        let newRegion = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(newRegion, animated: true)
        //oneTimeInit()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureLocationManager() {
        CLLocationManager.locationServicesEnabled()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = 1.0
        locationManager.distanceFilter = 100.0
        locationManager.startUpdatingLocation()
    }
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapView.removeAnnotations(mapView.annotations)
        
        updateRegionQuery()
    }
    
    func updateRegionQuery() {
        if let oldQuery = regionQuery {
            oldQuery.removeAllObservers()
        }
        regionQuery = geoFire?.query(with: mapView.region)
        
        regionQuery?.observe(.keyEntered, with: { (key, location) in
            self.ref?.queryOrderedByKey().queryEqual(toValue: key).observe(.value, with: { snapshot in
                
                let newSchool = School(key:key,snapshot:snapshot)
                self.addSchool(newSchool)
            })
        })
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.setRegion(MKCoordinateRegionMake((mapView.userLocation.location?.coordinate)!, MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
    }
    
    func addSchool(_ school : School) {
        DispatchQueue.main.async {
            self.mapView.addAnnotation(school)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is School {
            let annotationView = MKPinAnnotationView()
            annotationView.pinTintColor = .red
            annotationView.annotation = annotation
            annotationView.canShowCallout = true
            annotationView.animatesDrop = true
            
            let disclosureButton = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = disclosureButton
            return annotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "mapDetail", sender: view.annotation!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // add conditional
        if segue.identifier == "mapDetail" {
            if let selectedSchool = sender as? School {
                let destVC = segue.destination as! MapDetailViewController
                destVC.school = selectedSchool
                
            }
        }
    }
    
}

