//
//  BrandResponse.swift
//  Mycar
//
//  Created by Roberto Filho on 17/03/23.
//

import Foundation

struct BrandResponse: Decodable {
    let codigo: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case codigo
        case name = "nome"
    }
}
