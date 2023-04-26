//
//  HomeViewModel.swift
//  Mycar
//
//  Created by Roberto Filho on 28/02/23.
//

import Foundation
import SwiftUI
import Combine

class CarsViewModel: ObservableObject {
    
    @Published var cars = [CarsModel]()
    @Published var isLoading: Bool = false
    @Published var detailCar: [String] = []
    @Published var brand: String = ""
    @Published var model: String = ""
    @Published var description: String = ""
    @Published var year: String = ""
    @Published var showDetail = false
    
    @Published var uiState: CarUiState = .none
    
    init() {
        getCars()
    }
    
    func getCars() {
        let cars1 = CarsModel(brand: "Volkswagen", model: "T-Cross", description: "Comfortline 1.0 200 TSI", year: "2022")
        let cars2 = CarsModel(brand: "FIAT", model: "PULSE", description: "IMPETUS 1.0 TURBO 200", year: "2022")
        let cars3 = CarsModel(brand: "RENAULT", model: "KWID", description: "1.0", year: "2019")
        

        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.cars.append(cars1)
            self.cars.append(cars2)
            self.cars.append(cars3)
            self.isLoading = false
        }
    }
    
    func addCar(brand: String, model: String, description: String, year: String) {
        self.uiState = .loading
        let newCar = CarsModel(brand: brand, model: model, description: description, year: year)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.cars.append(newCar)
            self.showDetail = false
            self.uiState = .success
        }
    }
    
    
    func deleterawCar(index: IndexSet) {
        cars.remove(atOffsets: index)
    }
    
    func deleteCar(car: CarsModel) {
        cars.removeAll(where: { $0.id == car.id })
    }
    
    func updateCar(car: CarsModel) {
        if let index = cars.firstIndex(where: { $0.id == car.id}) {
            cars[index] = car
        }
    }
    
    func move(indexSet: IndexSet, newOffset: Int) {
        detailCar.move(fromOffsets: indexSet, toOffset: newOffset)
    }
}
