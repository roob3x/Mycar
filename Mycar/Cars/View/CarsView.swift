    //
    //  HomeView.swift
    //  Mycar
    //
    //  Created by Roberto Filho on 28/02/23.
    //

    import SwiftUI

    struct CarsView: View {
        @ObservedObject var viewModel: CarsViewModel

        var body: some View {
            NavigationView {
                List{
                    if viewModel.isLoading {
                        ProgressView()
                    }
                    else {
                        if viewModel.cars.count == 0 {
                            
                            VStack(spacing: 12) {
                                
                                Image(systemName: "exclamationmark.octagon.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60, alignment: .center)
                                
                                Text("Voce nao possui carros cadastrados :(")
                            }
                            .background(.white)
                        }
                        else {
                                ForEach(viewModel.cars) { cars in
                                    HStack() {
                                        Image("\(cars.model.lowercased())")
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(
                                                Circle()
                                            ).frame(width: 100, height: 100, alignment: .leading)
                                        CarRow(car: cars, onUpdate: viewModel.updateCar)
                                    }
                                }
                                .onDelete(perform: viewModel.deleterawCar)
                                .onMove(perform: { indices, newOffset in
                                    viewModel.cars.move(fromOffsets: indices, toOffset: newOffset)
                                })
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Meus Carros")
                .navigationBarItems(leading: EditButton(), trailing: NavigationLink(destination: newCarScreen, isActive: $viewModel.showDetail, label: {
                    Text("Add")
                }))
            }
        }
    }


struct CarRow: View {
    let car: CarsModel
    let onUpdate: (CarsModel) -> Void
    @State var isSelected = false
    var body: some View {
        HStack {
            NavigationLink("\(car.model)", destination: DetailScreen(car: car), isActive: $isSelected)
                .onTapGesture {
                    isSelected.toggle()
            }

        }
    }
}

extension CarsView {
    var newCarScreen: some View {
        ZStack {
            VStack(spacing: 0) {
                Form {
                    EditTextView(text: $viewModel.brand, placeholder: "Marca *", keyboard: .alphabet, error: "Marca nao pode ser nulo", failure: viewModel.brand.isEmpty, autocapitalization: .words)
                    EditTextView(text: $viewModel.model, placeholder: "Modelo *", keyboard: .alphabet, error: "Modelo nao pode ser nulo", failure: viewModel.model.isEmpty, autocapitalization: .words)
                    EditTextView(text: $viewModel.description, placeholder: "Versao *", keyboard: .alphabet, error: "Versao nao pode ser nulo", failure: viewModel.description.isEmpty, autocapitalization: .words)
                    EditTextView(text: $viewModel.year, placeholder: "Ano Modelo *", keyboard: .numberPad, error: "Ano nao pode ser nulo", failure: viewModel.year.isEmpty, autocapitalization: .words)
                    
                    LoadingButton(action: {
                        
                        viewModel.addCar(brand: viewModel.brand, model: viewModel.model, description: viewModel.description, year: viewModel.year)
                        
                        viewModel.brand = ""
                        viewModel.model = ""
                        viewModel.description = ""
                        viewModel.year = ""
                        
                        
                    }, text: "Cadastrar", showProgress: self.viewModel.uiState == CarUiState.loading, disabled: viewModel.brand.isEmpty || viewModel.model.isEmpty || viewModel.description.isEmpty || viewModel.year.isEmpty)
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Cadastro de Veiculo")
                .navigationBarTitleDisplayMode(.inline)
            }
            
        }
        
    }
}

struct DetailScreen: View {
    let car: CarsModel
    var body: some View {
        ZStack(alignment: .trailing) {
            VStack(spacing: 0) {
                List {
                    Text("Marca: " + car.brand)
                    Text("Modelo: " + car.model)
                    Text("Versao: " + car.description)
                    Text("Ano/Modelo: " + car.year)
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Detalhe do Veiculo")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        CarsView(viewModel: CarsViewModel())
    }
}
