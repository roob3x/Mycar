//
//  SplashViewModel.swift
//  Mycar
//
//  Created by Roberto Filho on 28/02/23.
//

import Foundation
import SwiftUI

class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUiState = .loading
    
    init () {
        
    }
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.uiState = .goToHome
        }
    }

}

extension SplashViewModel {
    func homeView() -> some View {
        return SplashViewRouter.makeCarsView()
    }
}
