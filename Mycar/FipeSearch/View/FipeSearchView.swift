//
//  FipeSearchView.swift
//  Mycar
//
//  Created by Roberto Filho on 30/03/23.
//

import SwiftUI

struct FipeSearchView: View {
    @ObservedObject var viewModel: FipeSerachViewModel
    var body: some View {
        NavigationView {
            List{
                    VStack(spacing: 10) {
                        if case let FipeSearchUiState.fullListBrand(brands) = viewModel.uiState {
                            Picker("Marca:", selection: $viewModel.selectedBrandOption) {
                                ForEach(brands) { brand in
                                    Text("\(brand.nome)")
                                        .accessibilityIdentifier("brandfipeText")
                                }
                            }
                            .onAppear(perform: viewModel.onAppearModel)
                        }
                    }
                    
                    VStack(spacing: 10) {
                            Picker("Modelo:", selection: $viewModel.selectedModelOption) {
                                if case let FipeSearchUiState.fullListModel(models) = viewModel.uiStateModel {
                                    ForEach(models) { model in
                                        Text("\(model.nome)")
                                            .accessibilityIdentifier("modelText")
                                    }
                                }
                            }.onAppear(perform: viewModel.onAppearYear)
                        }
                    
                    VStack(spacing: 10) {
                            Picker("Ano/Combustivel:", selection: $viewModel.selectedYearOption) {
                                if case let FipeSearchUiState.fullListYear(years) = viewModel.uiStateYear {
                                ForEach(years) { year in
                                    Text(year.nome)
                                        .accessibilityIdentifier("fuelText")
                                }
                            }
                        }.onAppear(perform: viewModel.onAppearDescription)
                    }
                
                VStack {
                    HStack {
                        Text("Codigo Fipe: ")
                        Spacer()
                        if case let FipeSearchUiState.fullListDescription(descriptions) = viewModel.uiStateDescription {
                                ForEach(descriptions, id: \.id) { description in
                                    if viewModel.selectedModelOption.isEmpty || viewModel.selectedYearOption.isEmpty {
                                                    Text("")
                                    }
                                    else {
                                        Text(description.fipe)
                                            .disabled(true)
                                            .foregroundColor(Color.gray)
                                            .multilineTextAlignment(.trailing)
                                            .accessibilityIdentifier("codigofipeText")
                                    }
                                }
                            }
                    }
                }
                    
                    VStack {
                        HStack {
                            Text("Valor Fipe: ")
                            Spacer()
                            if case let FipeSearchUiState.fullListDescription(descriptions) = viewModel.uiStateDescription {
                                    ForEach(descriptions, id: \.id) { description in
                                        if viewModel.selectedModelOption.isEmpty || viewModel.selectedYearOption.isEmpty {
                                                        Text("")
                                        }
                                        else {
                                            Text(description.price)
                                                .disabled(true)
                                                .foregroundColor(Color.gray)
                                                .multilineTextAlignment(.trailing)
                                                .accessibilityIdentifier("valueText")
                                        }
                                    }
                                }
                        }
                    }

                    
                    VStack {
                        HStack {
                            Text("Mes de referencia: ")
                            Spacer()
                            if case let FipeSearchUiState.fullListDescription(descriptions) = viewModel.uiStateDescription {
                                    ForEach(descriptions, id: \.id) { description in
                                        if viewModel.selectedModelOption.isEmpty || viewModel.selectedYearOption.isEmpty {
                                                        Text("")
                                        }
                                        else {
                                            Text(description.valueref)
                                                .disabled(true)
                                                .foregroundColor(Color.green)
                                                .multilineTextAlignment(.trailing)
                                                .accessibilityIdentifier("refText")
                                        }
                                    }
                                }
                        }
                    }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Consulta Tabela Fipe")
        }
    }
}

struct FipeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        FipeSearchView(viewModel: FipeSerachViewModel(brandId: 1, modelId: 1, yearId: "1", interector: CarInterector()))
    }
}
