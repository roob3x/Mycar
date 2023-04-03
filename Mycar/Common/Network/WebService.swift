//
//  WebService.swift
//  Mycar
//
//  Created by Roberto Filho on 17/03/23.
//

import Foundation

enum WebService {
    enum Endpoint: String {
      case base = "https://parallelum.com.br/fipe/api/v1"
      case getBrand = "/carros/marcas"
      case getModel = "/%d/modelos"
      case getYear = "/%d/anos/"
    }
    
    enum NetworkError {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Method: String {
        case get
        case post
        case put
        case delete
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum ContentType: String {
      case json = "application/json"
      case formUrl = "application/x-www-form-urlencoded"
      case multipart = "multipart/form-data"
    }
    
    private static func completeUrl(path: String) -> URLRequest? {
      guard let url = URL(string: "\(Endpoint.base.rawValue)\(path)") else { return nil }
      
      return URLRequest(url: url)
    }
    
    private static func call(path: String,
                             method: Method,
                             contentType: ContentType,
                             data: Data?,
                             boundary: String = "",
                             completion: @escaping (Result) -> Void) {
      
      guard var urlRequest = completeUrl(path: path) else { return }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
          // roda em background (Non-MainThread)
          guard let data = data, error == nil else {
            print(error)
            completion(.failure(.internalServerError, nil))
            return
          }
          
          if let r = response as? HTTPURLResponse {
            switch r.statusCode {
              case 400:
                completion(.failure(.badRequest, data))
                break
              case 401:
                completion(.failure(.unauthorized, data))
                break
              case 200:
                completion(.success(data))
                break
              case 201:
                completion(.success(data))
                break
              default:
                break
            }
          }
          
        }
        task.resume()
    }
    
    public static func call(path: Endpoint,
                            method: Method = .get,
                            completion: @escaping (Result) -> Void) {
      
      call(path: path.rawValue, method: method, contentType: .json, data: nil, completion: completion)
    }
    
    public static func call(path: String,
                            method: Method = .get,
                            completion: @escaping (Result) -> Void) {
      
      call(path: path, method: method, contentType: .json, data: nil, completion: completion)
    }

}
