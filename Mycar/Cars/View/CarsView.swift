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
                    EditTextView(text: $viewModel.brand, placeholder: "Marca *", keyboard: .alphabet, error: "Por favor, Inserir marca maior que 2 caracteres\n", failure: viewModel.brand.count < 3, autocapitalization: .words)
                    EditTextView(text: $viewModel.model, placeholder: "Modelo *", keyboard: .alphabet, error: "Por favor, Inserir modelo maior que 2 caracteres\n", failure: viewModel.model.count < 3, autocapitalization: .words)
                    EditTextView(text: $viewModel.description, placeholder: "Versao *", keyboard: .alphabet, error: "Por favor, Inserir versao maior que 5 caracteres\n", failure: viewModel.description.count < 6, autocapitalization: .words)
                    EditTextView(text: $viewModel.year, placeholder: "Ano Modelo *", keyboard: .numberPad, error: "Por favor insira ano maior que 1940 ou ate 2024\n", failure: Int(viewModel.year) ?? 0 < 1940 || Int(viewModel.year) ?? 0 > 2024, autocapitalization: .words)
                    
                    LoadingButton(action: {
                        
                        viewModel.addCar(brand: viewModel.brand, model: viewModel.model, description: viewModel.description, year: viewModel.year)
                        
                        viewModel.brand = ""
                        viewModel.model = ""
                        viewModel.description = ""
                        viewModel.year = ""
                        
                        
                    }, text: "Cadastrar", showProgress: self.viewModel.uiState == CarUiState.loading, disabled: viewModel.brand.count < 3 || viewModel.model.count < 3 ||
                                  viewModel.description.count < 6 || Int(viewModel.year) ?? 0 < 1940 || Int(viewModel.year) ?? 0 > 2024)
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


struct CarsView_Previews: PreviewProvider {
    static var previews: some View {
        CarsView(viewModel: CarsViewModel())
    }
}
