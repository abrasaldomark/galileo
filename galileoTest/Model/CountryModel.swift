//
//  CountryModel.swift
//  galileoTest
//
//  Created by Mark Abrasaldo on 5/2/21.
//

import Foundation

struct Country: Codable {
    var alpha2Code: String?
    var alpha3Code: String?
    var capital: String?
    var image: String?
    var name: String?
    var population: String?
}
