//
//  NetworkManager.swift
//  My achievements
//
//  Created by Elenka on 01.09.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init () {}
    
    func fetchData(from url: String, completion: @escaping (Result<JasonData, AFError>) -> Void) {
        AF.request(url).validate().responseDecodable(of: JasonData.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
