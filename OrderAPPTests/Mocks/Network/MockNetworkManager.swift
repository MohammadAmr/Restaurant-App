//
//  MockNetworkManager.swift
//  OrderAPPTests
//
//  Created by Mohamed AMR on 3/4/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import Foundation
@testable import OrderAPP

class MockNetworkManager: networkService {
    func submitOrder(forMenuIDs menuIDs: [Int], completion: @escaping (Result<Int, Error>) -> Void) {
        
    }
    
    
    var fileName: String?
    let baseURL = URL(string: "http://localhost:8080/")!
    
    init(fileName: String){
        self.fileName = fileName
    }
    
    
    func fetchCategories<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        guard let data = data(in: fileName, extension: "json") else {
            assertionFailure("Unable to find the file with name: \(fileName ?? "")")
            return
        }
        
        do {
            let apiResponse = try JSONDecoder().decode(T.self, from: data)
            completion(.success(apiResponse))
            
        } catch {
            completion(.failure(OrderAppError.decodingError))
            print(error.localizedDescription)
        }
    }
    func fetchMenuItems<T>(forCategory categoryName: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable{
        guard let data = data(in: fileName, extension: "json") else {
            assertionFailure("Unable to find the file with name: \(fileName ?? "")")
            return
        }
        
        do {
            let apiResponse = try JSONDecoder().decode(T.self, from: data)
            completion(.success(apiResponse))
        } catch {
            completion(.failure(OrderAppError.decodingError))
            print(error.localizedDescription)
        }
    }

    
    /// Data in file
    /// - Parameters:
    ///   - fileName: File name
    ///   - extension: File extensio
    /// - Returns: Optional data
    func data(in fileName: String?, extension: String?) -> Data? {
        guard let path = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: `extension`) else {
            assertionFailure("Unable to find file name \(String(describing: fileName))")
            return nil
        }
        
        guard let data = try? Data(contentsOf: path) else {
            assertionFailure("Unable to parse data")
            return nil
        }
        
        return data
    }
    
    enum OrderAppError: Error {
        case decodingError
    }
}

