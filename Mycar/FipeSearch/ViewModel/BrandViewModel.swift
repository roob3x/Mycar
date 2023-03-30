//
//  FipeCarViewModel.swift
//  Mycar
//
//  Created by Roberto Filho on 17/03/23.
//

import Foundation
import SwiftUI

struct BrandViewModel: Identifiable, Equatable {
    
    var id: String = ""
    var nome: String = ""
     
    static func == (lhs: BrandViewModel, rhs: BrandViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
