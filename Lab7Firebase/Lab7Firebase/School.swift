//
//  School.swift
//  Lab7Firebase
//
//  Created by Lucas Robertson on 5/20/18.
//  Copyright © 2018 lrober09. All rights reserved.
//

import Foundation
import Firebase
import MapKit

struct School : Codable {
    
    var name : String
    var city : String
    var state : String
    var zip : String
    var contact_email : String
    var latitude : Double
    var longitude : Double
    
    
}

