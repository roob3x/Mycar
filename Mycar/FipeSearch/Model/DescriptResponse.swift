//
//  DescriptionResponse.swift
//  Mycar
//
//  Created by Roberto Filho on 23/03/23.
//

import Foundation

struct DescriptResponse: Decodable {
    let codigo: Int
    let price: String
    let brand: String
    let model: String
    let year: Int
    let fuel: String
    let fipe: String
    let valueref: String
    let abbreviationfuel: String
    
    enum CodingKeys: String, CodingKey {
        case codigo = "TipoVeiculo"
        case price = "Valor"
        case brand = "Marca"
        case model = "Modelo"
        case year = "AnoModelo"
        case fuel = "Combustivel"
        case fipe = "CodigoFipe"
        case valueref = "MesReferencia"
        case abbreviationfuel = "SiglaCombustivel"
    }
}
