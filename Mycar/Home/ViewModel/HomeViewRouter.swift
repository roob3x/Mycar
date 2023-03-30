//
//  HomeViewRouter.swift
//  Mycar
//
//  Created by Roberto Filho on 30/03/23.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    
    static func makeCarsView() -> some View {
        return CarsView(viewModel: CarsViewModel())
    }
    
    static func makeFipeSearchView(viewModel: FipeSerachViewModel) -> some View {
//        return CarsView(viewModel: CarsViewModel())
//        return CarsView(viewModel: CarsViewModel(brandId: id, modelId: id, yearId: yearId, interector: CarInterector()))
//        return FipeSearchView(viewModel: FipeSerachViewModel(brandId: id, modelId: id, yearId: yearId, interector: CarInterector()))
        return FipeSearchView(viewModel: viewModel)
    }
    
}
