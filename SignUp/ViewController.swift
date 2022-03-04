//
//  ViewController.swift
//  SignUp
//
//  Created by WG Yang on 2022/02/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField_id: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        
        //UserInformation에 정보있으면 id 불러오기, 없으면 빈칸으로 설정.
        if let userId = UserInformation.shared.id {
            textField_id.text = userId
        } else {
            textField_id.text = ""
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

