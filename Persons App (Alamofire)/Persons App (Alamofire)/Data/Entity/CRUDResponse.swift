//
//  CRUDResponse.swift
//  Persons App (Alamofire)
//
//  Created by Ahmet Erkut on 25.10.2023.
//

import Foundation

class CRUDResponse: Codable { // CR-> Create, U-> Update, D-> Delete
    var success: Int?
    var message: String?
}
