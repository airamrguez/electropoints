//
//  ChargingPoint.swift
//  ElectroPoints
//
//  Created by Airam Rguez on 11/03/2020.
//  Copyright © 2020 Airam Rguez. All rights reserved.
//

import Foundation
import MapKit

enum ConnectorType: Int {
    typealias RawValue = Int
    
    case schuko = 1, mennekes, chademo
}

class ChargingPoint: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var name: String
    var street: String
    var power: Double
    var price: Double
    var type: ConnectorType
    
    var title: String? {
        get {
            return name
        }
    }
    
    var subtitle: String? {
        get {
            return street
        }
    }
    
    internal init(coordinate: CLLocationCoordinate2D, name: String, street: String, power: Double, price: Double, type: ConnectorType) {
        self.coordinate = coordinate
        self.name = name
        self.street = street
        self.power = power
        self.price = price
        self.type = type
        super.init()
    }
}
