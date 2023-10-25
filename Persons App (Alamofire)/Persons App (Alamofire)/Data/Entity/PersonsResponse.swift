//
//  PersonsResponse.swift
//  Persons App (Alamofire)
//
//  Created by Ahmet Erkut on 25.10.2023.
//

import Foundation

class PersonsResponse : Codable {
    var kisiler: [Persons]?
    var success: Int?
}
