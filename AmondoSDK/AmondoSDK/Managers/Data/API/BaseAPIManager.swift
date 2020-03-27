//
//  BaseAPIManager.swift
//  Amondo
//
//  Created by developer@amondo.com on 5/8/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import UIKit
import Alamofire
import Apollo

//static let API_URL = "https://api.staging-amondo.herokuapp.com"

//TODO, we can shift these constants in a .plsit file and have a plist file for each target configuration
struct Constants {
    static let BASE_API_URL = "https://api.amondo.com"
    static let RELAY_STAGING_URL = "https://amondo-relay.herokuapp.com"
    static let AUTH_API_URL = "https://auth.amondo.com"
}

class BaseAPIManager: NSObject {

    static func request(url: String,
                        method: Alamofire.HTTPMethod,
                        parameters: [String: Any?]? = nil,
                        encoding: ParameterEncoding = JSONEncoding.default,
                        completion: @escaping CompletionBlock) {
        NetworkManager.request(url: Constants.BASE_API_URL + url, method: method,
                               parameters: parameters, encoding: encoding,
                               headers: amondoHeaders()) { data, error in
                                completion(data, error)
        }
    }

    static func authRequest(url: String,
                            method: Alamofire.HTTPMethod,
                            parameters: [String: Any?]? = nil,
                            encoding: ParameterEncoding = JSONEncoding.default,
                            completion: @escaping CompletionBlock) {
        NetworkManager.request(url: Constants.AUTH_API_URL + url, method: method,
                               parameters: parameters, encoding: encoding,
                               headers: amondoHeaders()) { data, error in
                                completion(data, error)
        }
    }

    //where T.Type is Struct implementing decodable protocol
    static func request<T>(url: String,
                           method: Alamofire.HTTPMethod,
                           for type: T.Type,
                           parameters: [String: Any?]? = nil,
                           encoding: ParameterEncoding = JSONEncoding.default,
                           completion: @escaping (T?, AmondoError?) -> Void) where T: Decodable {
        request(url: url, method: method, parameters: parameters, encoding: encoding) { data, error in
            let (object, err) = BaseAPIManager.parseData(data: data, for: type, error: error)
            completion(object, err)
        }
    }

    static func authRequest<T>(url: String,
                               method: Alamofire.HTTPMethod,
                               for type: T.Type,
                               parameters: [String: Any?]? = nil,
                               encoding: ParameterEncoding = JSONEncoding.default,
                               completion: @escaping (T?, AmondoError?) -> Void) where T: Decodable {
        authRequest(url: url, method: method, parameters: parameters, encoding: encoding) { data, error in
            let (object, err) = BaseAPIManager.parseData(data: data, for: type, error: error)
            completion(object, err)
        }
    }

    static func amondoHeaders() -> [String: String]? {

        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Prefer": "return=representation"
        ]

        if let token = UserDefaults.standard.string(forKey: "AMDUSERDEFAULTS_token") {
            headers["Authorization"] = "Bearer \(token)"
        }

        return headers
    }

    static func parseData<T>(data: Data?,
                                     for type: T.Type,
                                     error: Error?) -> (T?, AmondoError?) where T: Decodable {
        return NetworkManager.parse(data: data, for: type, error: error)
    }

    //TODO: REMOVE LATER, ONCE THE CALLS ARE SHIFTED TO USE BASE API FUNCTIONS
    class func stripUrl(string: String) -> URL? {
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

public class Network {
    static let shared = Network()
    var networkTransport: HTTPNetworkTransport?
    var apollo: ApolloClient?
    
    func configure() {
        networkTransport = HTTPNetworkTransport(url: URL(string: "https://graphql.amondo.com/")!)
        networkTransport!.delegate = self
        apollo = ApolloClient(networkTransport: networkTransport!)
    }
}

// MARK: - Pre-flight delegate

extension Network: HTTPNetworkTransportPreflightDelegate {

    public func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          shouldSend request: URLRequest) -> Bool {
    // If there's an authenticated user, send the request. If not, don't.
    return true
  }
  
    public func networkTransport(_ networkTransport: HTTPNetworkTransport,
                        willSend request: inout URLRequest) {
                        
    // Get the existing headers, or create new ones if they're nil
    var headers = request.allHTTPHeaderFields ?? [String: String]()

    // Add any new headers you need
    headers["Authorization"] = "Bearer \(AMDUser.currentUser()?.token ?? "")"
  
    // Re-assign the updated headers to the request.
    request.allHTTPHeaderFields = headers
  }
}
