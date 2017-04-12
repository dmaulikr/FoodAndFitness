//
//  ResponseSerializer.swift
//  FoodAndFitness
//
//  Created by Mylo Ho on 3/7/16.
//  Copyright © 2016 SuHoVan. All rights reserved.
//

import Alamofire
import SwiftUtils
import RealmSwift
import ObjectMapper
import RealmS
import SwiftyJSON

extension Request {
    static func responseJSONSerializer(
        log: Bool = true,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?) -> Result<JSObject> {
        guard let response = response else {
            return .failure(NSError(status: .requestTimeout))
        }

        logger.info("\n response -> \(response)") // URL response

        if let error = error {
            return .failure(error)
        }

        let statusCode = response.statusCode

        if 204...205 ~= statusCode { // empty data status code
            return .success([:])
        }

        guard 200...299 ~= statusCode else {
            var err: NSError!
            if let json = data?.toJSON() as? JSObject, let errors = json["errors"] as? JSArray, !errors.isEmpty, let message = errors[0]["value"] as? String {
                err = NSError(message: message)
            } else if let status = HTTPStatus(code: statusCode) {
                err = NSError(domain: ApiPath.baseURL.host, status: status)
            } else {
                err = NSError(domain: ApiPath.baseURL.host,
                              code: statusCode,
                              message: "Unknown HTTP status code received (\(statusCode)).")
            }

            return .failure(err)
        }

        guard let data = data, let json = data.toJSON() as? JSObject else {
            return Result.failure(FFError.json)
        }

        logger.info("\n data -> \(json)")
        if let token = Session.Token(headers: response.allHeaderFields) {
            api.session.token = token
        }

        return .success(json)
    }
}

extension DataRequest {
    static func responseSerializer() -> DataResponseSerializer<JSObject> {
        return DataResponseSerializer { _, response, data, error in
            return Request.responseJSONSerializer(log: true, response: response, data: data, error: error)
        }
    }

    func responseJSON(queue: DispatchQueue? = nil, completion: @escaping (DataResponse<JSObject>) -> Void) -> Self {
        return response(responseSerializer: DataRequest.responseSerializer(), completionHandler: completion)
    }
}
