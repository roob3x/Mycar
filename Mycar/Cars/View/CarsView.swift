    //
    //  HomeView.swift
    //  Mycar
    //
    //  Created by Roberto Filho on 28/02/23.
    //

    import SwiftUI

    struct CarsView: View {
        @ObservedObject var viewModel: CarsViewModel
        @Environment(\.presentationMode) var presentationMode
        @State var isSelected = false
        

        var body: some View {

            NavigationView {
                List{
                    if viewModel.isLoading {
                        ProgressView()
                    }
                    else {
                        ForEach(viewModel.carsArray) { cars in
                            HStack{
                                NavigationLink("\(cars.model)", destination: DetailScreen, isActive: $isSelected)
                                        .font(.headline)
                                        .onTapGesture {
                                            viewModel.detailCar.append(cars.brand)
                                            viewModel.detailCar.append(cars.model)
                                            viewModel.detailCar.append(cars.description)
                                            viewModel.detailCar.append(cars.year)
                                            isSelected.toggle()
                                        }
                            }
                        }
                        .onDelete(perform: viewModel.deleteCar)
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Meus Carros")
                .navigationBarItems(leading: EditButton(), trailing: Button("Add", action: {
                    viewModel.carsArray.append(CarsModel(brand: "Volkswagen", model: "Polo", description: "Highline 1.0 TURBO", year: "2018"))
                }))
            }
        }
    }

extension CarsView {
    var DetailScreen: some View {
        NavigationView {
            List {
                Section(header: Text("Detalhe")) {
                    ForEach(viewModel.detailCar, id: \.self) { detail in
                        Text(detail.capitalized)
                    }
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
