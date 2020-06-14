//
//  ErrorAlert.swift
//  ElectroPoints
//
//  Created by Airam Rguez on 15/03/2020.
//  Copyright © 2020 Airam Rguez. All rights reserved.
//

import Foundation
import UIKit

class ErrorAlert {
    static func showError(_ message: String, controller: UIViewController) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(defaultAction)
        
        controller.present(alert, animated: true, completion: nil)
    }
}
