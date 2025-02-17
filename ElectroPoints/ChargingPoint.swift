//
//  ChargingPoint.swift
//  ElectroPoints
//
//  Created by Airam Rguez on 11/03/2020.
//  Copyright © 2020 Airam Rguez. All rights reserved.
//

import Foundation
import MapKit

class ChargingPoint: NSObject, MKAnnotation, Codable {
    var coordinates: Coordinate
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
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
    
    internal init(coordinates: Coordinate, name: String, street: String, power: Double, price: Double, type: ConnectorType) {
        self.coordinates = coordinates
        self.name = name
        self.street = street
        self.power = power
        self.price = price
        self.type = type
        super.init()
    }
    
    func getDistance(from other:CLLocation) -> CLLocationDistance {
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        return location.distance(from: other)
    }
}

enum ConnectorType: Int, CaseIterable, CustomStringConvertible, Codable {
    typealias RawValue = Int
    
    case schuko = 1, mennekes, chademo
    var description: String {
        switch self {
        case .schuko:
            return "Schuko"
        case .mennekes:
            return "Mennekes"
        case .chademo:
            return "Chademo"
        }
    }
}

protocol ChargingPointDelegate {
    func onChargingPointReady(_ chargingPoint: ChargingPoint)
}

struct Coordinate: Codable, Hashable {
    let latitude: Double
    let longitude: Double
}
