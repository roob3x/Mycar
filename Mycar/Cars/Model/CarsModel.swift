//
//  CarsModel.swift
//  Mycar
//
//  Created by Roberto Filho on 28/02/23.
//

import Foundation

struct CarsModel: Identifiable {

    var id = UUID()
    var brand: String
    var model: String
    var description: String
    var year: String

}
