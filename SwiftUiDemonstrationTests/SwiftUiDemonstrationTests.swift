//
//  SwiftUiDemonstrationTests.swift
//  SwiftUiDemonstrationTests
//
//  Created by  Macbook on 08.09.2020.
//  Copyright © 2020 Golovelv Maxim. All rights reserved.
//

import XCTest
import Combine

class SwiftUiDemonstrationTests: XCTestCase {

    var userService: UserService?
    var cancellable: AnyCancellable?
    
    override func setUp() {
        userService = UserService()
    }

    override func tearDown() {
        userService = nil
        cancellable = nil
    }

    func test() {
        
        cancellable = userService?.fetchUser(id: 1).sink(receiveCompletion: { (completion) in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
            }
        }, receiveValue: { (user) in
            XCTAssertEqual(user.name, "Leanne Graham")
        })
        
    }

}
