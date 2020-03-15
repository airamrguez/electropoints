//
//  ChargingPointsService.swift
//  ElectroPoints
//
//  Created by Airam Rguez on 14/03/2020.
//  Copyright © 2020 Airam Rguez. All rights reserved.
//

import Foundation

class PointsService {
    static let shared = PointsService()
    var allPoints: [ChargingPoint] = [] {
        didSet {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            if let data = try? encoder.encode(allPoints) {
                UserDefaults.standard.set(data, forKey: "AllPoints")
            }
        }
    }
    
    func loadPoints() {
        if let points = UserDefaults.standard.data(forKey: "AllPoints") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ChargingPoint].self, from: points) {
                self.allPoints = decoded
                return
            }
        }
    }
}
