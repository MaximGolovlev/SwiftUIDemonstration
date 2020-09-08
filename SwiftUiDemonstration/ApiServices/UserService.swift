//
//  UserService.swift
//  DemonstrationApp
//
//  Created by  Macbook on 08.09.2020.
//  Copyright © 2020 Golovelv Maxim. All rights reserved.
//

import Foundation
import Combine

class UserService: APIService {

    func fetchUser(id: Int) -> AnyPublisher<User, AppError> {
        
        let router = UserApiRouter.fetchUser(id: id)
        
        return SessionManager.default
            .perform(request: router.asURLRequest())
            .decode(type: User.self, decoder: jsonDecoder)
            .mapError({ (error) -> AppError in
                return AppError.serializationError(error: error)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchUsers() -> AnyPublisher<[User], AppError> {
        
        let router = UserApiRouter.fetchUsers
        
        return SessionManager.default
            .perform(request: router.asURLRequest())
            .decode(type: [User].self, decoder: jsonDecoder)
            .mapError({ (error) -> AppError in
                return AppError.serializationError(error: error)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}


