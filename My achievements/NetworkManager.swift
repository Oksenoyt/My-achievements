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
    
    func fetchData(from url: String, completion: @escaping (Result<[Country], AFError>) -> Void) {
        AF.request(url).validate().responseDecodable(of: [Country].self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchImg(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url).validate().responseData { dataRequest in
            switch dataRequest.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
