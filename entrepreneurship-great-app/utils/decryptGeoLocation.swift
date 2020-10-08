//
//  decryptGeoLocation.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 07/10/20.
//

import Foundation
import CoreLocation

public func decryptGeoLocation(_ location: CLLocation, completionHandler: @escaping (String?) -> ()){
    let geocoder = CLGeocoder()
    
    geocoder.reverseGeocodeLocation(location) {
        placemarkers, error in
        
        guard error == nil else {
            print(error.debugDescription)
            return
        }
        
        if let firstPlacemark = placemarkers?.first {
            completionHandler(firstPlacemark.name)
        }
    }
}
