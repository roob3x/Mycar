//
//  ModelViewModel.swift
//  Mycar
//
//  Created by Roberto Filho on 18/03/23.
//

import Foundation

import SwiftUI

struct ModeloViewModel: Identifiable, Equatable {
    var id: String = ""
    var nome: String = ""
     
    static func == (lhs: ModeloViewModel, rhs: ModeloViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct AnoViewModel: Identifiable, Equatable {
    var id: String {
        return codigo
    }
    var codigo: String = ""
    var nome: String = ""
     
    static func == (lhs: AnoViewModel, rhs: AnoViewModel) -> Bool {
        return lhs.codigo == rhs.codigo
    }
}

