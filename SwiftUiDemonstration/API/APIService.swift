//
//  APIService.swift
//  APIStructureTest
//
//  Created by Максим Головлев on 07/02/2020.
//  Copyright © 2020 Максим Головлев. All rights reserved.
//

import Foundation

protocol APIService {
    var jsonDecoder: JSONDecoder { get }
}

extension APIService {

    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
