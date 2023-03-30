//
//  ModelResponse.swift
//  Mycar
//
//  Created by Roberto Filho on 18/03/23.
//

import Foundation

struct Model: Decodable {
    let codigo: Int
    let nome: String
}

struct Year: Decodable {
    let codigo: String
    let nome: String
}

struct ModelResponse: Decodable {
    let modelos: [Model]
    let anos: [Year]
}
