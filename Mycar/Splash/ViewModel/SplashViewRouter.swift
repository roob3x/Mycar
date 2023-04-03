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
}

