//
//  CategoryAPIManager.swift
//  Amondo
//
//  Created by developer@amondo.com on 4/26/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import UIKit
import Alamofire

class CategoryAPIManager: NSObject {

    class func parseUrl(string: String) -> String {
        var urlString = string
        let allowedCharacterSet = (CharacterSet(charactersIn: "<>,{} ").inverted)

        if let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            urlString = escapedString
        } else {
            return ""
        }

        return urlString
    }

    class func loadCategoriesInBackground(completion:@escaping (_ error: AmondoError?, _ objects: [AMDCategory]) -> Void) {

        let url = BaseAPIManager.stripUrl(string: "/categories?order=priority&enabled=eq.true&select=*,genres(*,Events(*)),Events(*)")

        BaseAPIManager.request(url: url!.absoluteString, method: .get, for: [AMDCategory].self) { categories, error in
            completion(error, categories ?? [])
        }
    }
}
