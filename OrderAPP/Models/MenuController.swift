//
//  MenuController.swift
//  OrderAPP
//
//  Created by Mohamed AMR on 2/25/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import Foundation
import UIKit

protocol networkService {
    func fetchCategories<T : Decodable>(completion: @escaping (Result<T, Error>) -> Void)
    func fetchMenuItems<T: Decodable>(forCategory categoryName: String, completion: @escaping (Result<T, Error>) -> Void)
    func submitOrder(forMenuIDs menuIDs: [Int], completion: @escaping (Result<Int, Error>) -> Void)
}


class MenuController : networkService{
    
    let baseURL = URL(string: "http://localhost:8080/")!
    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    var order = Order(){
        didSet {
                NotificationCenter.default.post(name:
                   MenuController.orderUpdatedNotification, object: nil)
            }
    }
    static let shared = MenuController()
    private init()
    {
        
    }
    func fetchCategories<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let categoriesURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoriesURL)
        {
            (data, response, error) in
            if let data = data {
                do{
                    let jsonDecoder = JSONDecoder()
                    let categoriesResponse = try
                        jsonDecoder.decode(T.self, from: data)
                    completion(.success(categoriesResponse))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    func fetchMenuItems<T>(forCategory categoryName: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable
    {
        let baseMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: baseMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        
        let task = URLSession.shared.dataTask(with: menuURL)
            {
                (data, response, error) in
                if let data = data {
                    do{
                        let jsonDecoder = JSONDecoder()
                        let menuResponse = try jsonDecoder.decode(T.self, from: data)
                        completion(.success(menuResponse))
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                }
            }
            task.resume()
    }
    func submitOrder(forMenuIDs menuIDs: [Int], completion: @escaping (Result<Int, Error>) -> Void){
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        
        let data = ["menuIds" : menuIDs]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request)
        {
            (data, response, error) in
            if let data = data {
                do{
                    let jsonDecoder = JSONDecoder()
                    let orderResponse = try
                        jsonDecoder.decode(OrderResponse.self, from: data)
                    completion(.success(orderResponse.prepTime))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
