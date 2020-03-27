//
//  NetworkManager.swift
//  Amondo
//
//  Created by developer@amondo.com on 8/23/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

typealias CompletionBlock = (Data?, AmondoError?) -> Void

struct NetworkManager {

    private init() {}

    private static func configureSession() {
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 5.0
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForResource = 5.0
    }

    static func request(url: String,
                        method: Alamofire.HTTPMethod,
                        parameters: [String: Any]? = nil,
                        encoding: ParameterEncoding = JSONEncoding.default,
                        headers: HTTPHeaders? = nil,
                        completion: @escaping CompletionBlock) {
        configureSession()
        let strippedUrl = NetworkManager.stripUrl(string: url)

        Alamofire.request(strippedUrl!, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .responseData { response in
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 200...299:
                        completion(response.data, nil)
                    case 401, 403:
                        print("force logout")
                    default:
                        let (obj, err) = parse(data: response.data, for: AmondoError.self, error: nil) 
                        if obj != nil {
                            completion(response.data, .none)
                        } else {
                            completion(response.data, AmondoError(code: "SOMETHING_WRONG", message: "API_ERROR"))
                        }
                    }
                } else {
                    completion(response.data, AmondoError(code: "SOMETHING_WRONG", message: "NO RESPONSE"))
                }
        }
    }

    static func parse<T>(data: Data?, for type: T.Type, error: Error?) -> (T?, AmondoError?)
        where T: Decodable {
            if let error = error {
                return (nil, AmondoError(error: error))
            } else {
                let (object, err) = NetworkManager.deserializeJson(type, from: data)

                if let errorObject = object as? AmondoError {
                    return (object, .none)
                }
                
                if let err = err {
                    return (.none, AmondoError(error: err))
                } else {
                    return (object, .none)
                }
            }
    }

    private static func deserializeJson<T>(_ type: T.Type, from data: Data?) -> (T?, Error?) where T: Decodable {
        guard let data = data else {
            return (nil, nil)
        }
        do {
            let decoder = JSONDecoder()
            let deserializedObject = try decoder.decode(type, from: data)
            return (deserializedObject, nil)
        } catch let err {
            return (nil, err)
        }
    }

    private static func stripUrl(string: String) -> URL? {
        var urlString = string
        let allowedCharacterSet = (CharacterSet(charactersIn: "<>,{} ").inverted)

        if let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            urlString = escapedString
        } else {
            return URL(string: "")
        }
        return URL(string: urlString)
    }
}
