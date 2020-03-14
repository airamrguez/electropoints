//
//  ChargingPointListItem.swift
//  ElectroPoints
//
//  Created by Airam Rguez on 14/03/2020.
//  Copyright © 2020 Airam Rguez. All rights reserved.
//

import Foundation
import UIKit

class ChargingPointListItem: UITableViewCell {
    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var throughfare: UILabel!
    @IBOutlet weak var locality: UILabel!
    @IBOutlet weak var power: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var chargingTypeTop: UIImageView!
    @IBOutlet weak var chargingTypeBottom: UIImageView!
}
