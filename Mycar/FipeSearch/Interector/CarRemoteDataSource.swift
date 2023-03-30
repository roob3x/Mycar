//
//  CarRemoteDataSource.swift
//  Mycar
//
//  Created by Roberto Filho on 17/03/23.
//

import Foundation
import Combine

class CarRemoteDataSource {
    static var shared: CarRemoteDataSource = CarRemoteDataSource()
    
    private init () {
        
    }
    
    func fetchBrand() -> Future<[BrandResponse], AppError> {
        return Future<[BrandResponse], AppError> { promise in
            
            WebService.call(path: .getBrand, method: .get) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        
                        let decoder = JSONDecoder()
//                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
//                        print(response)
//                        promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode([BrandResponse].self, from: data)
//                    completion(response, nil)
                    
                    guard let res = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(res))
                    
                    break
                }
            }
            
        }
    }
    
    func fetchModel(brandId: Int) -> Future<ModelResponse, AppError> {
        return Future<ModelResponse, AppError> { promise in
            let path = String(format: WebService.Endpoint.getBrand.rawValue + WebService.Endpoint.getModel.rawValue, brandId)
            WebService.call(path: path, method: .get) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        
                        let decoder = JSONDecoder()
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(ModelResponse.self, from: data)
                    
                    guard let res = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(res))
                    
                    break
                }
            }
            
        }
    }
    
    func fetchYear(modelId: Int, brandId: Int) -> Future<[YearResponse], AppError> {
        return Future<[YearResponse], AppError> { promise in
            let path = String(format: WebService.Endpoint.getBrand.rawValue + WebService.Endpoint.getModel.rawValue , brandId) + String(format: WebService.Endpoint.getYear.rawValue, modelId)
            WebService.call(path: path, method: .get) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        
                        let decoder = JSONDecoder()
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode([YearResponse].self, from: data)
                    
                    guard let res = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    promise(.success(res))
                    
                    break
                }
            }
        }
    }
    
    func fetchDescription(modelId: Int, brandId: Int, yearId: String) -> Future<DescriptResponse, AppError> {
        return Future<DescriptResponse, AppError> { promise in
            let path = String(format: WebService.Endpoint.getBrand.rawValue + WebService.Endpoint.getModel.rawValue , brandId) + String(format: WebService.Endpoint.getYear.rawValue, modelId) + yearId
            WebService.call(path: path, method: .get) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        
                        let decoder = JSONDecoder()
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(DescriptResponse.self, from: data)
                    
                    guard let res = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    promise(.success(res))
                    
                    break
                }
            }
        }
    }
}
