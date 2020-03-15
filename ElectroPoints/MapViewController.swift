//
//  ViewController.swift
//  ElectroPoints
//
//  Created by Airam Rguez on 10/03/2020.
//  Copyright © 2020 Airam Rguez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

let DELTA: CLLocationDistance = 1700.0;

class MapViewController: UIViewController, ChargingPointDelegate {
    func onChargingPointReady(_ point: ChargingPoint) {
        mapView.addAnnotation(point)
        PointsService.shared.allPoints.append(point)
    }
    

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alcoy = CLLocationCoordinate2D(latitude: 38.70545, longitude: -0.47432)
        let region = MKCoordinateRegion(center: alcoy, latitudinalMeters: DELTA, longitudinalMeters: DELTA)
        mapView.setRegion(region, animated: true)
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onMapLongPress))
        mapView.addGestureRecognizer(gestureRecognizer)
        
        // Load previous points
        mapView.addAnnotations(PointsService.shared.allPoints)
    }

    // MARK: - UILongPressGestureRecognizer Action -
    @objc func onMapLongPress(gestureRecognizer:UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let screenPoint = gestureRecognizer.location(in: mapView)
            let mapPoint = mapView.convert(screenPoint, toCoordinateFrom: mapView)

            let location = CLLocation(latitude: mapPoint.latitude, longitude: mapPoint.longitude)
            CLGeocoder().reverseGeocodeLocation(location) { [unowned self] (placemarks, error) in
                if error != nil {
                    ErrorAlert.showError("No se ha podido obtener información de la localización", controller: self)
                } else {
                    if let placemark = placemarks?[0] {
                        self.performSegue(withIdentifier: "addPoint",
                                          sender: (mapPoint, placemark))
                    }
                }
            }
        }
    }

    @IBSegueAction func addPoint(_ coder: NSCoder) -> FormViewController? {
        return FormViewController(coder: coder)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let formController = segue.destination as? FormViewController {
            let params = sender as! (CLLocationCoordinate2D, CLPlacemark)
            formController.coordinate = params.0
            formController.placemark = params.1
            
            formController.chargingPointDelegate = self
        }
    }
}

