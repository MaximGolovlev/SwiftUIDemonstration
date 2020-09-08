//
//  SessionManager.swift
//  APIStructureTest
//
//  Created by Максим Головлев on 31/01/2020.
//  Copyright © 2020 Максим Головлев. All rights reserved.
//

import Foundation
import Combine


typealias HTTPHeaders = [String: String]

protocol SessionManagable: class {
    static var `default`: SessionManagable { get }
    static var acceptEncoding: String { get }
    static var acceptLanguage: String { get }
    static var userAgent: String { get }
    static var token: String { get }
    static var defaultHTTPHeaders: HTTPHeaders { get }
    
    var session: URLSession { get set }
    
    init(configuration: URLSessionConfiguration, delegate: URLSessionDelegate?)
}

extension SessionManagable {
    
    static var defaultHTTPHeaders: HTTPHeaders {
        return [
            "Accept-Encoding": acceptEncoding,
            "Accept-Language": acceptLanguage,
            "User-Agent": userAgent,
            "Authorization": "Bearer \(token)"
        ]
    }
    
    static var acceptEncoding: String {
        return "gzip;q=1.0, compress;q=0.5"
    }
    
    static var acceptLanguage: String {
        return Locale.preferredLanguages.prefix(6).enumerated().map { index, languageCode in
            let quality = 1.0 - (Double(index) * 0.1)
            return "\(languageCode);q=\(quality)"
        }.joined(separator: ", ")
    }
    
    static var userAgent: String {
        if let info = Bundle.main.infoDictionary {
            let executable = info[kCFBundleExecutableKey as String] as? String ?? "Unknown"
            let bundle = info[kCFBundleIdentifierKey as String] as? String ?? "Unknown"
            let appVersion = info["CFBundleShortVersionString"] as? String ?? "Unknown"
            let appBuild = info[kCFBundleVersionKey as String] as? String ?? "Unknown"

            let osNameVersion: String = {
                let version = ProcessInfo.processInfo.operatingSystemVersion
                let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"

                let osName: String = {
                    #if os(iOS)
                        return "iOS"
                    #elseif os(watchOS)
                        return "watchOS"
                    #elseif os(tvOS)
                        return "tvOS"
                    #elseif os(macOS)
                        return "OS X"
                    #elseif os(Linux)
                        return "Linux"
                    #else
                        return "Unknown"
                    #endif
                }()

                return "\(osName) \(versionString)"
            }()

            return "\(executable)/\(appVersion) (\(bundle); build:\(appBuild); \(osNameVersion))"
        }
        
        return ""
    }
}


extension SessionManagable {
    
    func perform(request: URLRequest?) -> AnyPublisher<Data, AppError> {

        guard let request = request else {
            return Result.Publisher(.failure(AppError.badURLRequest)).eraseToAnyPublisher()
        }
        
        return
            URLSession.shared.dataTaskPublisher(for: request)
                .map({ $0.data })
                .mapError({ (error) -> AppError in
                    return AppError.sessionFailed(error: error)
                })
                .eraseToAnyPublisher()
    }
}

class SessionManager: SessionManagable {
    
    static var token: String {
        return ""
    }
    
    static var `default`: SessionManagable {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHTTPHeaders
        return SessionManager(configuration: configuration, delegate: nil)
    }
    
    var session: URLSession
    
    required init(configuration: URLSessionConfiguration, delegate: URLSessionDelegate?) {
        self.session = URLSession.init(configuration: configuration)
    }
}


