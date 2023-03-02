//
//  HomeViewModel.swift
//  Mycar
//
//  Created by Roberto Filho on 28/02/23.
//

import Foundation
import SwiftUI

class CarsViewModel: ObservableObject {
    
    @Published var carsArray: [CarsModel] = []
    @Published var isLoading: Bool = false
    @Published var detailCar: [String] = []
    static var shared: CarsViewModel = CarsViewModel()
    
    init() {
        getCars()
    }
    
    func getCars() {
        let cars1 = CarsModel(brand: "Volkswagen", model: "T-Cross", description: "Comfortline 1.0 200 TSI", year: "2022")
        let cars2 = CarsModel(brand: "FIAT", model: "PULSE", description: "IMPETUS 1.0 TURBO 200", year: "2022")
        let cars3 = CarsModel(brand: "RENUALT", model: "KWID", description: "1.0", year: "2019")

        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.carsArray.append(cars1)
            self.carsArray.append(cars2)
            self.carsArray.append(cars3)
            self.isLoading = false
        }

        
    }
    
    func deleteCar(index: IndexSet) {
        carsArray.remove(atOffsets: index)
    }
    
    func move(indexSet: IndexSet, newOffset: Int) {
        detailCar.move(fromOffsets: indexSet, toOffset: newOffset)
    }
}
