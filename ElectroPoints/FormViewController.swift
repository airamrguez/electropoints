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
            showError("El precio introducido no es válido")
            return
        }
        
        guard let power = Double(powerTextField.text!) else {
            showError("La potencia introducida no es válida")
            return
        }

        let row = connectorPickerView.selectedRow(inComponent: 0)
        let connectorType = ConnectorType.allCases[row]
        
        let chargingPoint = ChargingPoint(coordinate: coordinate!,
                      name: placemark?.thoroughfare ?? "",
                      street: placemark?.locality ?? "",
                      power: power,
                      price: price,
                      type: connectorType)
        chargingPointDelegate?.onChargingPointReady(chargingPoint)

        navigationController?.popViewController(animated: true)
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
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


