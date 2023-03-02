//
//  SplashViewRouter.swift
//  Mycar
//
//  Created by Roberto Filho on 28/02/23.
//

import Foundation
import SwiftUI

enum SplashViewRouter {
    static func makeCarsView() -> some View {
        return CarsView(viewModel: CarsViewModel())
    }
}

