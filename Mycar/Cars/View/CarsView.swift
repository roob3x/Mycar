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
                            CarRow(car: cars, onUpdate: viewModel.updateCar)
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
                        Text("Cadastrar").frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 16)
                            .font(Font.system(.title3).bold())
                            .background(.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(4.0)
                    })
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
