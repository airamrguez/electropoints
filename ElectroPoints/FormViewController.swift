//
//  FormViewController.swift
//  ElectroPoints
//
//  Created by Airam Rguez on 11/03/2020.
//  Copyright © 2020 Airam Rguez. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class FormViewController: UIViewController {
    var coordinate: CLLocationCoordinate2D?
    var placemark: CLPlacemark?
    
    override func viewDidLoad() {
        NSLog("coordinate -> %@", coordinate.debugDescription)
        NSLog("placemark -> %@", placemark ?? "nada")
    }
}
