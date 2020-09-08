//
//  UserViewModel.swift
//  SwiftUiDemonstration
//
//  Created by  Macbook on 08.09.2020.
//  Copyright © 2020 Golovelv Maxim. All rights reserved.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    
    let userService = UserService()
    
    @Published var user: User?
    
    var cancellable: AnyCancellable?

    func fetchUser(id: Int) {
        cancellable = userService.fetchUser(id: id).sink(receiveCompletion: { (completion) in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
            }
        }, receiveValue: { (user) in
            self.user = user
        })
    }
}
