//
//  Error.swift
//  FoodAndFitness
//
//  Created by Mylo Ho on 3/7/16.
//  Copyright © 2016 SuHoVan. All rights reserved.
//

import Foundation
import SwiftUtils
import Alamofire

typealias Network = NetworkReachabilityManager

// MARK: - Network
extension Network {
    static let shared: Network = {
        guard let manager = Network() else {
            fatalError("Cannot alloc network reachability manager!")
        }
        return manager
    }()
}

class FFError {
    static let network = NSError(domain: ApiPath.baseURL.host, status: HTTPStatus.requestTimeout, message: Strings.Errors.notNetwork)
    static let authentication = NSError(domain: ApiPath.baseURL.host, status: HTTPStatus.unauthorized)
    static let json = NSError(domain: NSCocoaErrorDomain, code: 3840, message: Strings.Errors.json)
    static let apiKey = NSError(domain: ApiPath.baseURL.host, code: 120, message: "")
}

extension Error {
    func show(level: AlertLevel = .normal) {
        let this = self as NSError
        this.show()
    }
}

extension NSError {
    func show(level: AlertLevel = .normal) {
        let alert = AlertController.alertWithError(self, level: level)
        alert.present()
    }
}

// MARK: Error Tracking
func fatal(_ msg: String) {
    let msg = msg + "\nYou must restart this application.\nThanks you!"
    DispatchQueue.main.async {
        let alert = AlertController(title: App.name, message: msg, preferredStyle: .alert)
        alert.level = .require
        alert.present()
    }
}

// Log error to Crashlytics and show required alert on Debug/Staging.
func assert(_ cond: Bool, _ msg: String) {
    guard !cond else { return }
    DispatchQueue.main.async {
        let alert = AlertController(title: "DEBUG", message: msg, preferredStyle: .alert)
        alert.level = .require
        alert.present()
    }
}
