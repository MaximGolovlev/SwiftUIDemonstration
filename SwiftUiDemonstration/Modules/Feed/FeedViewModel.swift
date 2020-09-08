//
//  UserViewModel.swift
//  SwiftUiDemonstration
//
//  Created by  Macbook on 08.09.2020.
//  Copyright © 2020 Golovelv Maxim. All rights reserved.
//

import Foundation
import Combine

class FeedViewModel: ObservableObject {
    
    let userService = UserService()
    
    @Published var users = [User]()
    
    var cancellable: AnyCancellable?
    
    func fetchUsers() {
        cancellable = userService.fetchUsers().sink(receiveCompletion: { (completion) in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
            }
        }, receiveValue: { (users) in
            self.users = users
        })
    }
}
