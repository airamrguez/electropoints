//
//  ListViewController.swift
//  ElectroPoints
//
//  Created by Airam Rguez on 14/03/2020.
//  Copyright © 2020 Airam Rguez. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
}

extension ListViewController: UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PointsService.shared.allPoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let point = PointsService.shared.allPoints[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "pointCell") as! ChargingPointCell

        cell.throughfare.text = point.name
        cell.locality.text = point.street
        cell.power.text = String(point.power)
        cell.price.text = String(point.price)

        return cell
    }
}
