//
//  OrderResponse.swift
//  OrderAPP
//
//  Created by Mohamed AMR on 2/25/22.
//  Copyright © 2022 Mohamed AMR. All rights reserved.
//

import Foundation

struct OrderResponse: Codable {
    let prepTime: Int
 
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
