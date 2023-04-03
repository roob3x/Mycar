//
//  DescriptViewModel.swift
//  Mycar
//
//  Created by Roberto Filho on 23/03/23.
//

import Foundation

struct DescriptViewModel: Identifiable, Equatable {
    
    var id: Int
    var price: String = ""
//    var brand: String = ""
//    var model: String = ""
//    var year: Int
//    var fuel: String = ""
    var fipe: String = ""
    var valueref: String = ""
//    var abbreviationfuel: String = ""
     
    static func == (lhs: DescriptViewModel, rhs: DescriptViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
