//
//  CarInterector.swift
//  Mycar
//
//  Created by Roberto Filho on 17/03/23.
//

import Foundation
import Combine

class CarInterector {
    private let remote: FipeRemoteDataSource = .shared
}

extension CarInterector {
    func fetchBrand() -> Future<[BrandResponse], AppError> {
        return remote.fetchBrand()
    }
    
    func fetchModel(brandId: Int) -> Future<ModelResponse, AppError> {
        return remote.fetchModel(brandId: brandId)
    }
    
    func fetchYear(modelId: Int, brandId: Int) -> Future<[YearResponse], AppError> {
        return remote.fetchYear(modelId: modelId, brandId: brandId)
    }
    
    func fetchDescription(modelId: Int, brandId: Int, yearId: String) -> Future<DescriptResponse, AppError> {
        return remote.fetchDescription(modelId: modelId, brandId: brandId, yearId: yearId)
    }
}
