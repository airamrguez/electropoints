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
    var allPoints: [ChargingPoint] = []
}
