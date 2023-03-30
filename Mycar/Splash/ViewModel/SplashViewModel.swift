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
    var id: Int = 0
    var yearId: String = ""
    
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
        return SplashViewRouter.makeHomeView()
    }
}
