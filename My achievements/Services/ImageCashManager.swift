//
//  ImageCashManager.swift
//  My achievements
//
//  Created by Elenka on 04.09.2022.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
