//
//  HomeView.swift
//  Mycar
//
//  Created by Roberto Filho on 30/03/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var selection = 0
    var body: some View {
        TabView(selection: $selection){
            viewModel.carsView()
                .tabItem {
                    Image(systemName: "car.circle")
                    Text("Carros")
                }.tag(0)
            
            viewModel.fipeSearchView()
                .tabItem {
                    Image(systemName: "wallet.pass")
                    Text("Fipe")
                }.tag(1)
        }
        .background(Color.white)
        .accentColor(Color.blue)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
