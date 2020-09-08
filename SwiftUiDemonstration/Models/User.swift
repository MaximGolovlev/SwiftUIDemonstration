//
//  User.swift
//  APIStructureTest
//
//  Created by Максим Головлев on 07/02/2020.
//  Copyright © 2020 Максим Головлев. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable, Hashable {
    let id: Int
    let name: String
    let email: String?
}
