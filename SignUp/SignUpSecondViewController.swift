//
//  SignUpSecondViewController.swift
//  SignUp
//
//  Created by WG Yang on 2022/02/18.
//

import UIKit

class SignUpSecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //'이전' 버튼 클릭 시.
    //수정필요.(정보 유지 되도록)
    @IBAction func popToPrev() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //'취소' 버튼 클릭시.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
