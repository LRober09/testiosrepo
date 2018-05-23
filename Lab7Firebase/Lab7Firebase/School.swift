//
//  School.swift
//  Lab7Firebase
//
//  Created by Lucas Robertson on 5/20/18.
//  Copyright © 2018 lrober09. All rights reserved.
//

import Foundation

struct School : Codable {
    
    var schools : [Schools]
    
    class Schools : Codable {
        var name : String
        var city : String?
        var state : String?
        var zip : String?
        var contact_email: String?
        var latitude : Double?
        var longitude : Double?
        
        func toAnyObject() -> Any {
            return [
                "name" : name,
                "city" : city,
                "state" : state,
                "zip" : zip,
                "contact_email" : contact_email,
                "latitude" : latitude,
                "longitude" : longitude,
            ]
        }
    }
    
}
