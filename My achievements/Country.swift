//
//  Country.swift
//  My achievements
//
//  Created by Elenka on 01.09.2022.
//

import Foundation

struct Country: Decodable {
    let name: String
    let capital: String?
    let region: String
    let nativeName: String
}
