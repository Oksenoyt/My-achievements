//
//  NetworkManager.swift
//  My achievements
//
//  Created by Elenka on 01.09.2022.
//

import Foundation
import Alamofire
import UIKit

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
    
    func fetchImg(from url: URL, completion: @escaping(Result<UIImage, AFError>) -> Void) {
        if let cachedImage = ImageCacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
            completion(.success(cachedImage))
            return
        }
        
        AF.request(url).validate().responseData { dataRequest in
            switch dataRequest.result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else {
                    print("нет картинки")
                    return }
                completion(.success(uiImage))
                ImageCacheManager.shared.setObject(uiImage, forKey: url.lastPathComponent as NSString)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
