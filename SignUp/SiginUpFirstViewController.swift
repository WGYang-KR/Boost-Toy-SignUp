//
//  SiginUpFirstViewController.swift
//  SignUp
//
//  Created by WG Yang on 2022/02/18.
//

import UIKit

class SiginUpFirstViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var textField_ID: UITextField!
    @IBOutlet var textField_Password: UITextField!
    @IBOutlet var textField_CheckPassword: UITextField!
    @IBOutlet var nextButton: UIButton!
    
    //두 텍스트필드 문자가 같은 지 확인.
    func isSameBothTextField(_ first: UITextField,_ second: UITextField) -> Bool {
        
        if(first.text == second.text) {
            return true
        } else {
            return false
        }
    }
    
    //텍스트 필드 입력값 변하면 유효성 검사
    @objc func TFdidChanged(_ sender: UITextField) {
        
        print("텍스트 변경 감지")
        print("text :", sender.text)
        
        //오류::::왜 1,2번째 조건 체크가 안될까.
        if !(self.textField_ID.text?.isEmpty ?? true)
            && !(self.textField_Password.text?.isEmpty ?? true)
            && isSameBothTextField(textField_Password, textField_CheckPassword) {
            updateNextButton(willActive: true)
        }
        else {
            
            updateNextButton(willActive: false)
        }
        
    }
    
    //'다음' 버튼 활성화/비활성화
    func updateNextButton(willActive: Bool) {
        
        if(willActive == true) {
            //다음 버튼 색 변경
            self.nextButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
            //다음 페이지 연결
            print("다음 버튼 활성화")
            
        } else {
            //다음 버튼 색 변경
            self.nextButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            //다음 페이지 연결 해제
            print("다음 버튼 비활성화")
        }
    }
    
    //취소 버튼 클릭시
    @IBAction func popToPrev() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.textField_ID.delegate = self
        self.textField_Password.delegate = self
        self.textField_CheckPassword.delegate = self
    
        //텍스트필드 입력값 변경 감지
        self.textField_ID.addTarget(self, action: #selector(self.TFdidChanged(_:)), for: .editingChanged)
        self.textField_Password.addTarget(self, action: #selector(self.TFdidChanged(_:)), for: .editingChanged)
        self.textField_CheckPassword.addTarget(self, action: #selector(self.TFdidChanged(_:)), for: .editingChanged)
    }
    
   
    /* 삭제예정
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField
        {
        case self.textField_ID,
            self.textField_Password,
            self.textField_CheckPassword :
            checkValidIdPass()
        default:
            break
        }
        
        return true
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
