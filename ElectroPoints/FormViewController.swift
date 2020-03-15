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
    var chargingPointDelegate: ChargingPointDelegate?
    
    @IBOutlet weak var thoroughfare: UILabel!
    @IBOutlet weak var locality: UILabel!
    @IBOutlet weak var coor: UILabel!
    @IBOutlet weak var connectorPickerView: UIPickerView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var powerTextField: UITextField!
    
    override func viewDidLoad() {
        thoroughfare.text = placemark?.thoroughfare ?? ""
        locality.text = placemark?.locality ?? ""
        coor.text = String(format: "%f,%f", coordinate?.latitude ?? "", coordinate?.longitude ?? "")
        connectorPickerView.delegate = self
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        guard let price = Double(priceTextField.text!) else {
            ErrorAlert.showError("El precio introducido no es válido", controller: self)
            return
        }
        
        guard let power = Double(powerTextField.text!) else {
            ErrorAlert.showError("La potencia introducida no es válida", controller: self)
            return
        }

        let row = connectorPickerView.selectedRow(inComponent: 0)
        let connectorType = ConnectorType.allCases[row]
        
        let coordinates = Coordinate(latitude: coordinate!.latitude, longitude: coordinate!.longitude)
        let chargingPoint = ChargingPoint(coordinates: coordinates,
                      name: placemark?.thoroughfare ?? "",
                      street: placemark?.locality ?? "",
                      power: power,
                      price: price,
                      type: connectorType)
        chargingPointDelegate?.onChargingPointReady(chargingPoint)

        navigationController?.popViewController(animated: true)
    }
}

extension FormViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ConnectorType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ConnectorType.allCases[row].description
    }
}


