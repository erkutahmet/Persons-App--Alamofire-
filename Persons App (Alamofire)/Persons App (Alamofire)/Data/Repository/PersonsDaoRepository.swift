//
//  PersonsDaoRepository.swift
//  Persons App (Draft Plan) MVVM
//
//  Created by Ahmet Erkut on 25.10.2023.
//

import Foundation
import RxSwift

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
        var list = [Persons]()
        let p1 = Persons(kisi_id: "1", kisi_ad: "Ahmet", kisi_tel: "1111")
        let p2 = Persons(kisi_id: "2", kisi_ad: "Zeynep", kisi_tel: "2222")
        let p3 = Persons(kisi_id: "3", kisi_ad: "Beyza", kisi_tel: "3333")
        list.append(p1)
        list.append(p2)
        list.append(p3)
        personsList.onNext(list)
    }
}
