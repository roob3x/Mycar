//
//  SplashView.swift
//  Mycar
//
//  Created by Roberto Filho on 28/02/23.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    var body: some View {
        Group {
            switch viewModel.uiState {
            case .loading:
                LoadingView()
            case .goToHome:
                viewModel.homeView()
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Image("splashCarros")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        }
        .background(.black)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: SplashViewModel())
    }
}
