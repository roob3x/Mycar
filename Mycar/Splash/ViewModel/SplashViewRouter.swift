//
//  SplashViewRouter.swift
//  Mycar
//
//  Created by Roberto Filho on 28/02/23.
//

import Foundation
import SwiftUI

enum SplashViewRouter {
    
    static func makeHomeView() -> some View {
        return HomeView(viewModel: HomeViewModel())
    }
    
//    static func makeCarsView(id: Int, yearId: String) -> some View {
//        return CarsView(viewModel: CarsViewModel())
//        return CarsView(viewModel: CarsViewModel(brandId: id, modelId: id, yearId: yearId, interector: CarInterector()))
//        return FipeSearchView(viewModel: FipeSerachViewModel(brandId: id, modelId: id, yearId: yearId, interector: CarInterector()))
//    }
}

