//
//  UserApiRouter.swift
//  SwiftUiDemonstration
//
//  Created by  Macbook on 08.09.2020.
//  Copyright © 2020 Golovelv Maxim. All rights reserved.
//

import Foundation

enum UserApiRouter: APIRouter {
    
    case fetchUser(id: Int)
    case fetchUsers
    
    var action: String {
        switch self {
        case .fetchUser(let id):
            return "/users/\(id)"
        case .fetchUsers:
            return "/users"
        }
    }
    
    var parameters: [String : String] {
        return [:]
        
    }
    
    var body: [String : Any]? {
        return nil
    }
    
    var dataKey: String? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
