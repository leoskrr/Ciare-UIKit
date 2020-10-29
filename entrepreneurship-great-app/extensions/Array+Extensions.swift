//
//  Array+Extensions.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 28/10/20.
//

import Foundation

extension Array where Element:Equatable{    
    func filterDuplicates( includeElement: @escaping (Element, Element) -> Bool) -> [Element]{
        var results = [Element]()
        
        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        
        return results
    }
}
