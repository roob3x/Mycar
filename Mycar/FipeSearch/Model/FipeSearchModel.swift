//
//  FipeSearchModel.swift
//  Mycar
//
//  Created by Roberto Filho on 30/03/23.
//

import Foundation

enum FipeSearchUiState: Equatable {
    case none
    case loading
    case success
    case error(String)
    case fullListBrand([BrandViewModel])
    case fullListModel([ModeloViewModel])
    case fullListYear([YearViewModel])
    case fullListDescription([DescriptViewModel])
}
