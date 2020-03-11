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

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alcoy = CLLocationCoordinate2D(latitude: 38.70545, longitude: -0.47432)
        
        let region = MKCoordinateRegion(center: alcoy, latitudinalMeters: DELTA, longitudinalMeters: DELTA)
        
        mapView.setRegion(region, animated: true)
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onMapLongPress))
        
        mapView.addGestureRecognizer(gestureRecognizer)
    }

    // MARK: - UILongPressGestureRecognizer Action -
    @objc func onMapLongPress(gestureRecognizer:UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let screenPoint = gestureRecognizer.location(in: mapView)
            let mapPoint = mapView.convert(screenPoint, toCoordinateFrom: mapView)

            let location = CLLocation(latitude: mapPoint.latitude, longitude: mapPoint.longitude)
            CLGeocoder().reverseGeocodeLocation(location) { [unowned self] (placemarks, error) in
                if let err = error {
                    print(err)
                } else {
                    if let placemark = placemarks?[0] {
                        self.performSegue(withIdentifier: "addPoint",
                                          sender: (mapPoint, placemark))
                        let annotation = ChargingPoint(coordinate: mapPoint,
                                                       name: placemark.thoroughfare!,
                                                       street: placemark.locality!,
                                                       power: 2.3,
                                                       price: 23.0,
                                                       type: .schuko)

                        self.mapView.addAnnotation(annotation)
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
        }
    }
}

