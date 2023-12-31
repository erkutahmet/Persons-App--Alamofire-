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
        let params: Parameters = ["kisi_ad": person_name,
                                  "kisi_tel": person_phone]
        
        AF.request("http://kasimadalan.pe.hu/kisiler/insert_kisiler.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print("Success: \(response.success!)")
                    print("Message: \(response.message!)")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func update(person_id: Int, person_name: String, person_phone: String) {
        let params: Parameters = ["kisi_id": person_id,
                                  "kisi_ad": person_name,
                                  "kisi_tel": person_phone]
        
        AF.request("http://kasimadalan.pe.hu/kisiler/update_kisiler.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print("Success: \(response.success!)")
                    print("Message: \(response.message!)")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }

    }
    
    func delete(person_id: Int) {
        let params: Parameters = ["kisi_id": person_id]
        
        AF.request("http://kasimadalan.pe.hu/kisiler/delete_kisiler.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print("Success: \(response.success!)")
                    print("Message: \(response.message!)")
                    self.uploadPersons()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func search(searchText: String) {
        let params: Parameters = ["kisi_ad": searchText]
        
        AF.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php", method: .post, parameters: params).response { response in
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
