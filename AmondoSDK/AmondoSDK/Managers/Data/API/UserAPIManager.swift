//
//  UserAPIManager.swift
//  Amondo
//
//  Created by developer@amondo.com on 5/15/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import UIKit
import Alamofire

class UserAPIManager: NSObject {

    class func resetPassword(email: String, completion:@escaping (_ error: AmondoError?, _ success: Bool) -> Void) {

        let parameters: Parameters = ["email": email, "form_link": "https://applink.amondo.com/reset_link"]

        BaseAPIManager.authRequest(url: "/password_reset_request", method: .post, parameters: parameters) { _, error in

            if let error = error {
                completion(error, false)
            } else {
                completion(.none, true)
            }
        }
    }

    class func changePassword(email: String, password: String, resetToken: String, completion:@escaping (_ error: AmondoError?, _ success: Bool, _ token: String?) -> Void) {

        let parameters: Parameters = ["email": email, "password": password, "password_confirmation": password, "password_reset_token": resetToken]

        BaseAPIManager.authRequest(url: "/password", method: .post, for: AMDTokenResponse.self, parameters: parameters) { response, error in

            if let error = error {
                completion(error, false, .none)
            } else if let response = response, let token = response.token {
                completion(.none, true, token)
            } else {
                let amondoError = AmondoError(code: "PASS1", message: "Error resetting password")
                completion(amondoError, false, .none)
            }
        }
    }
    
    class func passwordUpdate(current: String, new: String, completion:@escaping (_ error: AmondoError?, _ success: Bool, _ token: String?) -> Void) {
        
        let parameters: Parameters = ["current_password": current, "new_password": new, "new_password_confirmation": new]
        
        BaseAPIManager.authRequest(url: "/rpc/change_password", method: .post, for: AMDTokenResponse.self, parameters: parameters) { response, error in
            
            if let error = error {
                completion(error, false, .none)
            } else if let response = response, let token = response.token {
                completion(.none, true, token)
            } else {
                let amondoError = AmondoError(code: "PASS1", message: "Error resetting password")
                completion(amondoError, false, .none)
            }
        }
    }

    class func getContributedEvents(completion:@escaping (_ error: AmondoError?, _ success: Bool, _ events: [AMDImprintItem]?) -> Void) {

        var urlstring = "/Events?select=endDate,startDate,id,geoPoint&order=date.desc&filterLocation=is.true"
        let allowedCharacterSet = (CharacterSet(charactersIn: "<>,{} ").inverted)
        if let escapedString = urlstring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            urlstring = escapedString
        } else {
            return
        }

        BaseAPIManager.request(url: urlstring, method: .get, for: [AMDImprintItem].self) { imprints, error in
            if let error = error {
                completion(error, false, nil)
            } else {
                completion(nil, true, imprints)
            }
        }
    }

    class func saveNewEventContributed(event: String, completion:@escaping (_ error: AmondoError?, _ success: Bool) -> Void) {

        let parameters: Parameters = ["event_id": event]

        BaseAPIManager.request(url: "/events_users_contributed", method: .post, parameters: parameters) { _, error in
            if let error = error {
                completion(error, false)
            } else {
                completion(.none, true)
            }
        }
    }

    class func saveNewEventNotification(event: String, completion:@escaping (_ error: AmondoError?, _ success: Bool) -> Void) {

        let parameters: Parameters = ["event_id": event]

        BaseAPIManager.request(url: "/events_users_notified", method: .post, parameters: parameters) { _, error in
            if let error = error {
                completion(error, false)
            } else {
                completion(.none, true)
            }
        }
    }

    class func saveNewEvent(event: String, completion:@escaping (_ error: AmondoError?, _ success: Bool) -> Void) {

        let parameters: Parameters = ["event_id": event]

        BaseAPIManager.request(url: "/events_users", method: .post, parameters: parameters) { _, error in
            if let error = error {
                completion(error, false)
            } else {
                completion(.none, true)
            }
        }
    }

    class func deleteEventNotification(event: String, completion:@escaping (_ error: AmondoError?, _ success: Bool) -> Void) {

        BaseAPIManager.request(url: "/events_users_notified?event_id=eq.\(event)", method: .delete) { _, error in
            if let error = error {
                completion(error, false)
            } else {
                completion(.none, true)
            }
        }
    }

    class func deleteEvent(event: String, completion:@escaping (_ error: AmondoError?, _ success: Bool) -> Void) {

        BaseAPIManager.request(url: "/events_users?event_id=eq.\(event)", method: .delete) { _, error in
            if let error = error {
                completion(error, false)
            } else {
                completion(.none, true)
            }
        }
    }
    
    class func deleteUser( completion:@escaping (_ error: AmondoError?, _ success: Bool) -> Void) {
        BaseAPIManager.request(url: "/User", method: .delete) { _, error in
            if let error = error {
                completion(error, false)
            } else {
                completion(.none, true)
            }
        }
    }
    
    class func loginUser(user: AMDUser, completion:@escaping (_ error: AmondoError?, _ success: Bool, _ token: String?) -> Void) {

        let parameters: Parameters = ["email": user.username!, "password": user.password!]

        BaseAPIManager.authRequest(url: "/login", method: .post, for: AMDTokenResponse.self, parameters: parameters) { response, error in

            if let error = error {
                completion(error, false, .none)
            } else if let token = response?.token {
                UserDefaults.standard.set(token, forKey: "AMDUSERDEFAULTS_token")
                user.token = token

                UserAPIManager.remoteAttributesForUser(user: user, completion: { (error: AmondoError?, _: Bool, _: AMDUser?) in

                    if let error = error {
                        completion(error, false, nil)
                    } else {
                        AMDDefaults.Standard.setString(key: "username", value: user.username!)
                        AMDDefaults.Standard.setString(key: "token", value: user.token!)

                        UserDefaults.standard.setValue(user.username, forKey: "LoggedInUser")
                        completion(nil, true, token)
                    }
                })
            } else if let message = response?.message {
                let amondoError = AmondoError(code: .none, message: message)
                completion(amondoError, false, nil)
            } else {
                let amondoError = AmondoError(code: .none, message: "No token")
                completion(amondoError, false, nil)
            }
        }
    }

    class func registerUser(user: AMDUser, completion:@escaping (_ error: AmondoError?, _ success: Bool, _ token: String?) -> Void) {

        let parameters: Parameters = ["email": user.username!, "username": user.username!, "password": user.password!, "password_confirmation": user.password!]

        BaseAPIManager.authRequest(url: "/signup", method: .post, for: AMDTokenResponse.self, parameters: parameters) { response, error in
            if let error = error {
                completion(error, false, nil)
            } else if let token = response?.token {
                user.token = token
                UserDefaults.standard.set(token, forKey: "AMDUSERDEFAULTS_token")

                var attributes: [String: Any] = ["firstName": user.firstName!, "savedEvents": user.savedEvents, "allEvents": user.allEvents!, "refCode": "", "username": user.username!, "email": user.username!]

                if let lastName = user.lastName {
                    attributes["lastName"] = lastName
                }

                UserAPIManager.updateRemoteAttributesForUser(user: user, attributes: attributes, completion: { (error: AmondoError?, _: Bool, newAttributes: AMDUser?) in

                    if let error = error {
                        completion(error, false, nil)
                    } else {
                        user.saveAsCurrentUser(withAttributes: newAttributes!.dictionary)
                        UserDefaults.standard.setValue(user.username!, forKey: "LoggedInUser")
                        completion(.none, true, token)
                    }
                })
            } else if let message = response?.message {
                let amondoError = AmondoError(code: .none, message: message)
                completion(amondoError, false, nil)
            } else {
                let amondoError = AmondoError(code: .none, message: "No token")
                completion(amondoError, false, nil)
            }
        }
    }

    class func remoteAttributesForUser(user: AMDUser, completion:@escaping (_ error: AmondoError?, _ success: Bool, _ user: AMDUser?) -> Void) {

        var baseurl = "https://api.amondo.com/User?select=*,events_users{*},events_users_notified{*},events_users_contributed{*}"
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "<>,{} @").inverted)
        
        if let escapedString = baseurl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            baseurl=escapedString
        } else {
            baseurl=""
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "AMDUSERDEFAULTS_token")!)",
        ]
        
        Alamofire.request(URL(string: baseurl)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch response.result {
            case .success:
                if let result = response.result.value as? Dictionary<String,Any> {
                    let code = result["code"] as! String
                    let message = result["message"] as! String
                    let error = AmondoError(code: "BAD_REQUEST", message: message);

                    completion(error, false, nil)
                    return
                }
                
                let attributes = (response.result.value as! NSArray).firstObject as! [String:Any]
                user.setLocalUserAttributes(attributes: attributes)
                
                completion(nil, true, user)
            case .failure(let error):
                let error = AmondoError(code: "BAD_REQUEST", message: error.localizedDescription);
                completion(error, false,nil)
            }
        }

    }

    class func updateRemoteAttributesForUser(user: AMDUser, attributes: [String: Any], completion:@escaping (_ error: AmondoError?, _ success: Bool, _ user: AMDUser?) -> Void) {

        var urlstring="/User?username=eq.\(user.username!)"

        let parameters: Parameters = attributes
        let allowedCharacterSet = (CharacterSet(charactersIn: "<>,{} @").inverted)

        if let escapedString = urlstring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            urlstring = escapedString
        } else {
            urlstring = ""
        }

        BaseAPIManager.request(url: urlstring, method: .patch, for: [AMDUser].self, parameters: parameters) { userArray, error in
            if let error = error {
                completion(error, false, .none)
            } else {
                if let user = userArray?.first {
                    completion(.none, true, user)
                } else {
                    let amondoError = AmondoError(code: "SOMETHING_WRONG", message: "Something went wrong")

                    completion(amondoError, false, .none)
                }
            }
        }
    }

}
