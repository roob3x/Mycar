//
//  FipeSearchViewModel.swift
//  Mycar
//
//  Created by Roberto Filho on 30/03/23.
//

import Foundation
import SwiftUI
import Combine

class FipeSerachViewModel:  ObservableObject {
    @Published var selectedBrandOption: String = ""
    @Published var selectedModelOption: String = ""
    @Published var selectedYearOption: String = ""
    
    @Published var uiState: FipeSearchUiState = .none
    @Published var uiStateModel: FipeSearchUiState = .none
    @Published var uiStateYear: FipeSearchUiState = .none
    @Published var uiStateDescription: FipeSearchUiState = .none
    
    private var cancellableBrandRequest: AnyCancellable?
    private var cancellableModelRequest: AnyCancellable?
    private var cancellableYearRequest: AnyCancellable?
    private var cancellableDescriptionRequest: AnyCancellable?
    
    @Published var brandId: Int
    @Published var modelId: Int
    @Published var yearId: String
    private let interector: CarInterector
    
    init(brandId: Int, modelId: Int, yearId: String, interector: CarInterector) {
        self.interector = interector
        self.brandId = brandId
        self.modelId = modelId
        self.yearId = yearId
        onAppearBrand()
    }
    
    deinit {
        cancellableBrandRequest?.cancel()
        cancellableModelRequest?.cancel()
        cancellableYearRequest?.cancel()
        cancellableDescriptionRequest?.cancel()
    }
    
    func onAppearBrand() {
        cancellableBrandRequest = interector.fetchBrand()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
                self.uiState = .fullListBrand(
                    response.map {
                        return BrandViewModel(id: $0.codigo ?? "", nome: $0.name)
                    }
                )
            })
    }
    
    func onAppearModel() {
        
        if !selectedBrandOption.isEmpty {
            if brandId != Int(selectedBrandOption) {
                selectedModelOption = ""
                selectedYearOption = ""
            }
            brandId = Int(selectedBrandOption) ?? 0
            cancellableModelRequest = interector.fetchModel(brandId: brandId)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch(completion) {
                    case .failure(let appError):
                        self.uiState = .error(appError.message)
                        break
                    case .finished:
                        break
                    }
                }, receiveValue: { response in
                    var modelosViewModel: [ModeloViewModel] = []
                        for modelo in response.modelos {
                            var modeloViewModel = ModeloViewModel()
                            modeloViewModel.id = "\(modelo.codigo)"
                            modeloViewModel.nome = modelo.nome
                            modelosViewModel.append(modeloViewModel)
                        }
                        self.uiStateModel = .fullListModel(modelosViewModel)
                })
        }
    }
    
    func onAppearYear() {
        if !selectedModelOption.isEmpty {
            if modelId != Int(selectedModelOption) {
                selectedYearOption = ""
            }
            modelId = Int(selectedModelOption) ?? 0
            cancellableYearRequest = interector.fetchYear(modelId: modelId, brandId: brandId)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch(completion) {
                    case .failure(let appError):
                        self.uiState = .error(appError.message)
                        break
                    case .finished:
                        break
                    }
                }, receiveValue: { response in
                    self.uiStateYear = .fullListYear(
                        response.map {
                            return YearViewModel(id: $0.codigo ?? "", nome: $0.nome)
                        }
                    )
                })
        }
    }
    
    func onAppearDescription() {
        if !selectedYearOption.isEmpty {
            yearId = selectedYearOption
            cancellableDescriptionRequest = interector.fetchDescription(modelId: modelId, brandId: brandId, yearId: yearId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
//                let viewModel = DescriptViewModel(id: response.codigo,
//                                                               price: response.price,
//                                                                valueref: response.valueref)
                let viewModel = DescriptViewModel(id: response.codigo, price: response.price, fipe: response.fipe, valueref: response.valueref)
                self.uiStateDescription = .fullListDescription([viewModel])
            })
        }
    }
    
}
