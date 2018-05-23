//
//  MapDetailViewController.swift
//  Lab7
//
//  Created by Lucas Robertson on 5/20/18.
//  Copyright © 2018 lrober09. All rights reserved.
//

import UIKit

class MapDetailViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var zip: UILabel!
    @IBOutlet weak var email: UILabel!
    var school : School?
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = school?.name
        email.text = school?.contact_email
        zip.text = school?.zip
        city.text = school?.city
        state.text = school?.state
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
