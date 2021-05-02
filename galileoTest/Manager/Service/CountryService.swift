//
//  CountryService.swift
//  galileoTest
//
//  Created by Mark Abrasaldo on 5/1/21.
//

import Foundation
import Alamofire

class CountryService {
    
    static let sharedInstance = CountryService()
    
    func getCountry(completion: @escaping([SuccessGetRESTCountryResponseModelElement]?, Error?) -> Void) {
    
        AF.request(ROUTE.init().getCountry,
                   method: .get,
                   parameters: nil,
                   headers: nil).response
        { response in
            
            switch response.result {
                case .success(_):
                    
                    print("response.response?.statusCode \(String(describing: response.response?.statusCode))")
                    print("response.result \(response.result)")
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                        print("Data ni niya: \(utf8Text)")
                    }
                    
                if response.response?.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let data: [SuccessGetRESTCountryResponseModelElement] = try decoder.decode([SuccessGetRESTCountryResponseModelElement].self, from: response.data!)
                        completion(data, nil)
                    }
                    catch {
                        print(error.localizedDescription)
                        debugPrint(error)
                    }
                }
                case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
