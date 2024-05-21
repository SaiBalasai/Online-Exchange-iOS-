//
//  UserModel.swift
//  Online Exchange
//
//  Created by Kumar Chandu on 5/21/24.
//

import Foundation

struct UserRegistrationModel {
    var firstname: String?
    var lastname: String?
    var email: String?
    var phone: String?
    var password: String?

    init(firstname: String?,lastname: String?, email: String?, phone: String?, password: String?) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.phone = phone
        self.password = password
    }
}


