//
//  ConsentAPIManager.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/1/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import UIKit
import Alamofire

class ConsentAPIManager: NSObject {

    class func setConsent(consentAnnouncments: Bool, consentRelevantEmails: Bool, consentRequiredEmails: Bool, completion:@escaping (_ error: AmondoError?) -> Void) {

        let urlstring = "/consent_storage"

        let parameters = ["consent": ["anouncements": consentAnnouncments, "relevant_emails": consentRelevantEmails, "required_emails":
            consentRequiredEmails]]

        BaseAPIManager.request(url: urlstring,
                               method: .post,
                               parameters: parameters) { _, error in
                                DispatchQueue.main.async {
                                    if let error = error {
                                        let amondoError = AmondoError(error: error)
                                        completion(amondoError)
                                    } else {
                                        completion(.none)
                                    }
                                }
        }
    }

    class func getConsent(completion:@escaping (_ error: AmondoError?, _ objects: [AMDConsentMeta]) -> Void) {

        let urlstring = "/actual_consent"

        BaseAPIManager.request(url: urlstring, method: .get, for: [AMDConsentMeta].self) { consent, error in
            completion(error, consent ?? [])
        }
    }

}
