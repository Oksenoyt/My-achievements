//
//  Country.swift
//  My achievements
//
//  Created by Elenka on 01.09.2022.
//

import Foundation

struct JasonData: Decodable {
    let data: [Country]
}

struct Country: Decodable {
    let country: String
//    let visited: Bool
}
