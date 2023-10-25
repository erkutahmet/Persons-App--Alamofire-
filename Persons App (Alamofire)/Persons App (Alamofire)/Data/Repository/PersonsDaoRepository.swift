//
//  PersonsDaoRepository.swift
//  Persons App (Draft Plan) MVVM
//
//  Created by Ahmet Erkut on 25.10.2023.
//

import Foundation
import RxSwift
import Alamofire

class PersonsDaoRepository {
    var personsList = BehaviorSubject<[Persons]>(value: [Persons]())
    
    func save(person_name: String, person_phone: String) {
        print("Person Save: \(person_name) - \(person_phone)")
    }
    
    func update(person_id: Int, person_name: String, person_phone: String) {
        print("Person Update: \(person_id) -> \(person_name), \(person_phone)")
    }
    
    func delete(person_id: Int) {
        print("Person Delete: \(person_id)")
        uploadPersons()
    }
    
    func search(searchText: String) {
        print("Person Search: \(searchText)")
    }
    
    func uploadPersons() {
        AF.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler.php", method: .get).response { response in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(PersonsResponse.self, from: data)
                    
                    if let list = response.kisiler {
                        self.personsList.onNext(list)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
