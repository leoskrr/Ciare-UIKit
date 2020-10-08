//
//  MapViewController.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 05/10/20.
//
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userBusinessLocationTextField: UITextField!
    
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    var callBack: ((CLLocationCoordinate2D) -> ())?
    
    var userBusinessLocationCoordinate = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        self.hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dismissTheKeyboard()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView?.isDraggable = true
            
            removeExistentsAnotations()
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        guard let annotation = view.annotation else {
            return
        }
        let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        
        reverseGeocodeLocationAndSetLocationName(location: location)
        callBack?(location.coordinate)
        userBusinessLocationCoordinate = location.coordinate
    }
    
    @IBAction func locationTextFieldDidEndEditing(_ sender: UITextField) {
        guard let location = sender.text else {
            print("No location typed")
            return
        }
        
        if !location.isEmpty {
            renderTypedBusinessLocation(location: location)
        }
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        reverseGeocodeLocationAndSetLocationName(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
        showPinInCoordinate(coordinate)
    }
    
    func renderTypedBusinessLocation(location: String) {
        geocoder.geocodeAddressString(location) {
            placemarks, error in
            
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            if let firstPlacemark = placemarks?.first {
                guard let coordinate = firstPlacemark.location?.coordinate else {
                    return
                }
                self.showPinInCoordinate(coordinate)
            }
        }
    }
    
    func reverseGeocodeLocationAndSetLocationName(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) {
            placemarkers, error in
            
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            if let firstPlacemark = placemarkers?.first {
                self.userBusinessLocationTextField.text = firstPlacemark.name
            }
        }
    }
    
    func removeExistentsAnotations() {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
    }
    
    func showPinInCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
        removeExistentsAnotations()
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        
        mapView.addAnnotation(pin)
        
        userBusinessLocationCoordinate = coordinate
        callBack?(coordinate)
    }
}

extension MapViewController: UITextFieldDelegate {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.dismissTheKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissTheKeyboard() {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
