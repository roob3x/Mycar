    //
    //  HomeView.swift
    //  Mycar
    //
    //  Created by Roberto Filho on 28/02/23.
    //

    import SwiftUI

    struct CarsView: View {
        @ObservedObject var viewModel: CarsViewModel
        @State private var showDetail = false

        var body: some View {
            NavigationView {
                List{
                    if viewModel.isLoading {
                        ProgressView()
                    }
                    else {
                        ForEach(viewModel.cars) { cars in
                            HStack{
                                CarRow(car: cars, onUpdate: viewModel.updateCar)
                            }
                        }
                        .onDelete(perform: viewModel.deleterawCar)
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Meus Carros")
                .navigationBarItems(leading: EditButton(), trailing: NavigationLink(destination: newCarScreen, isActive: $showDetail, label: {
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
            Spacer()
            NavigationLink("\(car.model)", destination: DetailScreen(car: car), isActive: $isSelected)
                .onTapGesture {
                    isSelected.toggle()
            }

        }
    }
}

extension CarsView {
    var newCarScreen: some View {
        NavigationView {
            Form {
                TextField("Marca", text: $viewModel.brand)
                TextField("Modelo", text: $viewModel.model)
                TextField("Versao", text: $viewModel.description)
                TextField("Ano Modelo", text: $viewModel.year)
                Button(action: {
                    viewModel.addCar(brand: viewModel.brand, model: viewModel.model, description: viewModel.description, year: viewModel.year)
                    viewModel.brand = ""
                    viewModel.model = ""
                    viewModel.description = ""
                    viewModel.year = ""
                    showDetail = false
                }, label: {
                    Text("Cadastrar novo Carro")
                })
            }
        }
        
    }
}

struct DetailScreen: View {
    @Environment(\.presentationMode) var presentationMode
    let car: CarsModel
    var body: some View {
        NavigationView {
                List {
                    Section(header: Text("Detalhe")) {
                        Text(car.brand)
                        Text(car.model)
                        Text(car.description)
                        Text(car.year)
                    }
                }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Veiculo")
    }
}


    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            CarsView(viewModel: CarsViewModel())
        }
    }
