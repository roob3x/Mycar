//
//  YearViewModel.swift
//  Mycar
//
//  Created by Roberto Filho on 23/03/23.
//

import Foundation

struct YearViewModel: Identifiable, Equatable {
    
    var id: String = ""
    var nome: String = ""
     
    static func == (lhs: YearViewModel, rhs: YearViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
