//
//  UserInfo.swift
//  SignUp
//
//  Created by WG Yang on 2022/03/01.
//

import Foundation
import UIKit


class UserInformation {
    static let shared: UserInformation = UserInformation()
    private init() {
        
    }
    
    func deleteData(){
    
        UserInformation.shared.id = nil
        UserInformation.shared.password = nil
        UserInformation.shared.aboutMe = nil
        UserInformation.shared.phoneNumber = nil
        UserInformation.shared.birthday = nil
        UserInformation.shared.birthdayDidChanged = false
        UserInformation.shared.photo = nil
        UserInformation.shared.photoDidChanged = false
        
        print("UserInformation 데이터 초기화")
        
    }
    
    var id: String?
    var password: String?
    var aboutMe: String?
    var phoneNumber: String?
    var birthday: Date?
    var birthdayDidChanged: Bool = false
    var photo: UIImage?
    var photoDidChanged: Bool = false
   
    
    //var photo
    //var birthday
    //var phoneNumber
}
