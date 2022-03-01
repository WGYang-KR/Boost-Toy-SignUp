//
//  UserInfo.swift
//  SignUp
//
//  Created by WG Yang on 2022/03/01.
//

import Foundation


class UserInfo {
    static let shared: UserInfo = UserInfo()
    
    var id: String?
    var password: String?
    var aboutMe: String?
    var phoneNumber: String?
    var birthday: String?
    
    //var photo
    //var birthday
    //var phoneNumber
}
