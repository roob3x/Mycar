//
//  HomeViewModel.swift
//  Mycar
//
//  Created by Roberto Filho on 30/03/23.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    let fipeSearchViewModel = FipeSerachViewModel(brandId: 1, modelId: 1, yearId: "1", interector: CarInterector())
    let carsViewModel = CarsViewModel()
}

extension HomeViewModel {
    
    func carsView() -> some View {
        return HomeViewRouter.makeCarsView()
    }
    
    func fipeSearchView() -> some View {
        return HomeViewRouter.makeFipeSearchView(viewModel: fipeSearchViewModel)
    }
}
