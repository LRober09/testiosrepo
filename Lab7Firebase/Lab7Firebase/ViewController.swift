//
//  ViewController.swift
//  Lab7Firebase
//
//  Created by Lucas Robertson on 5/20/18.
//  Copyright © 2018 lrober09. All rights reserved.
//

import UIKit
import Firebase
import GeoFire



class ViewController: UIViewController {
    
    var root : DatabaseReference!
    var geoFire : GeoFire?
    var regionQuery : GFRegionQuery?
    let locationManager = CLLocationManager()
    
    let schoolJSON = "https://code.org/schools.json"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadToFirebase()
    }
    
    func uploadToFirebase() {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let request = URLRequest(url: URL(string: schoolJSON)!)
        
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            
            if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    var schoolService = try decoder.decode(SchoolService.self, from: data)
                    schoolService.schools = schoolService.schools.filter( {($0.zip?.hasPrefix("93")) ?? false})
                    self.root = Database.database().reference().child("schools")
                    self.geoFire = GeoFire(firebaseRef: Database.database().reference().child("GeoFire"))
                    for item in schoolService.schools {
                        item.name = item.name.replacingOccurrences(of: ".", with: "")
                        let schoolRef = self.root?.child(item.name)
                        schoolRef?.setValue(item.toAnyObject())
                        self.geoFire?.setLocation(CLLocation(latitude:item.latitude!,longitude:item.longitude!), forKey: item.name)
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        
        task.resume()
    }
}

