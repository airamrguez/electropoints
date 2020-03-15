//
//  ListViewController.swift
//  ElectroPoints
//
//  Created by Airam Rguez on 14/03/2020.
//  Copyright © 2020 Airam Rguez. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var locationManager = CLLocationManager()
    var userLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        locationManager.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            locationManager.requestLocation()
        }
    }
}

extension ListViewController: UITableViewDataSource {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PointsService.shared.allPoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let point = PointsService.shared.allPoints[indexPath.row]
        let cell: ChargingPointCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "pointCell") as? ChargingPointCell else {
                return ChargingPointCell()
            }
            return cell
        }()
        
        let distance = userLocation != nil ? String.init(format: "%.2f kM", point.getDistance(from: userLocation!)) : ""

        cell.distance.text = distance
        cell.throughfare.text = point.name
        cell.locality.text = point.street
        cell.power.text = String(point.power)
        cell.price.text = String(point.price)

        return cell
    }
}

extension ListViewController: CLLocationManagerDelegate {    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: "Ha ocurrido un error al obtener su posición", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Permitir", style: .default)
        let actionCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0]
        tableView.reloadData()
    }
}
