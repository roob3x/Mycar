//
//  YearResponse.swift
//  Mycar
//
//  Created by Roberto Filho on 23/03/23.
//

import Foundation

struct YearResponse: Decodable {
    let codigo: String
    let nome: String
    
    enum CodingKeys: String, CodingKey {
        case codigo
        case nome
    }
}
