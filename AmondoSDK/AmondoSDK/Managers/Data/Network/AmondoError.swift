//
//  AmondoError.swift
//  Amondo
//
//  Created by developer@amondo.com on 8/23/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation

struct AmondoError: Error, Decodable {
    let code: String?
    let message: String?

    init(code: String?, message: String?) {
        self.code = code
        self.message = message
    }

    init(error: Error, code: String? = .none) {
        self.code = code
        self.message = error.localizedDescription
    }
}
