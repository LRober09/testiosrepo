//
//  School.swift
//  Lab7
//
//  Created by Lucas Robertson on 5/20/18.
//  Copyright © 2018 lrober09. All rights reserved.
//

import Foundation
import FirebaseDatabase
import MapKit

class School : NSObject, MKAnnotation{
    
    var name : String
    var city : String
    var state : String
    var zip : String
    var contact_email : String
    var latitude : Double
    var longitude : Double
    let ref: DatabaseReference?
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return city
    }
    
    init(name: String, city: String, state: String, zip: String, contact_email: String, latitude: Double, longitude: Double) {
        self.name = name
        self.city = city
        self.state = state
        self.zip = zip
        self.contact_email = contact_email
        self.latitude = 0
        self.longitude = 0
        ref = nil
        
        super.init()
    }
    
    init(key: String, snapshot: DataSnapshot) {
        name = key
        
        let snaptemp = snapshot.value as! [String : AnyObject]
        let snapvalues = snaptemp[key] as! [String : AnyObject]
        
        city = snapvalues["city"] as? String ?? "N/A"
        state = snapvalues["state"] as? String ?? "N/A"
        zip = snapvalues["zip"] as? String ?? "N/A"
        contact_email = snapvalues["contact_email"] as? String ?? "N/A"
        latitude = snapvalues["latitude"] as? Double ?? 0.0
        longitude = snapvalues["longitude"] as? Double ?? 0.0
        
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name" : name,
            "city" : city,
            "state" : state,
            "zip" : zip,
            "contact_email" : contact_email,
            "latitude" : latitude,
            "longitude" : longitude
        ]
    }
}
