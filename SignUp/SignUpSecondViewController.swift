//
//  SignUpSecondViewController.swift
//  SignUp
//
//  Created by WG Yang on 2022/02/18.
//

import UIKit

class SignUpSecondViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate{

    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var birthdayPicker: UIDatePicker!
    @IBOutlet var birthdayDisplay: UILabel!
    @IBOutlet var joinButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        
        
        if let phoneNumber = UserInformation.shared.phoneNumber { self.phoneNumberField.text = phoneNumber
        }
        if let birthDate = UserInformation.shared.birthday {
            self.birthdayPicker.date = birthDate
        }
        //생년월일 초기값 설정
        self.birthdayDisplay.text = self.dateFormatter.string(from: self.birthdayPicker.date)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneNumberField.delegate = self
        // Do any additional setup after loading the view.
        
        //데이트피커 값 변경 발생 시 함수연결
        self.birthdayPicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
        self.phoneNumberField.addTarget(self, action: #selector(self.TFdidChanged(_:)), for: .editingChanged)
        
        //배경 클릭시 키보드 사라지기 위한 제스처 할당.
        let tapBackgroundGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(tapGestureRecognizer:)))
        view.addGestureRecognizer(tapBackgroundGestureRecognizer)
                                                                    
    }
    
    //배경클릭 시
    @objc func backgroundTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //키보드 사라지게
        self.view.endEditing(true)
    }
    
    //데이트 포맷 변경 함수
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        //formatter.dateStyle = .medium
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }()
    
    //데이트피커 값 변동 시, label에 반영
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker) {
        print("value change")
        
        let date: Date = sender.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        UserInformation.shared.birthday = date
        UserInformation.shared.birthdayDidChanged = true
        self.birthdayDisplay.text = dateString
        
        self.checkValid()
        
    }
    
    
    //생년월일, 전화번호 다 채워졌는지.
    func checkValid() {
        //3개 텍스트필드가 채워졌는지, 비밀번호가 일치하는 지 확인.
        if !(self.phoneNumberField.text?.isEmpty ?? true)
            && UserInformation.shared.birthdayDidChanged == true
        {
            updateJoinButton(willActive: true)
        }
        else {
            
            updateJoinButton(willActive: false)
        }
        
        
    }
    
    //'다음' 버튼 활성화/비활성화
    func updateJoinButton(willActive: Bool) {


        if(willActive == true) {
    
            //다음 버튼 색 변경
            self.joinButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
            //다음 페이지 연결
            print("가입 버튼 활성화")
            
            self.joinButton.addTarget(self, action: #selector(completeJoin(_:)), for: UIControl.Event.touchUpInside)
            
            
        } else {
            //다음 버튼 색 변경
            self.joinButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            
            //다음 페이지 연결 해제
            print("가입 버튼 비활성화")
            self.joinButton.removeTarget(self, action: #selector(completeJoin(_:)), for: .touchUpInside)
        }
    }
    
    //텍스트 필드 입력값 변하면 유효성 검사
    @objc func TFdidChanged(_ sender: UITextField) {
        
        print("텍스트 변경 감지")
        print("text :", sender.text ?? "(Empty)")
        
        self.checkValid()
    }
    
    @objc func completeJoin(_ sender: Any?) {

        //UserInformation에 정보저장.
        UserInformation.shared.phoneNumber = self.phoneNumberField.text
        UserInformation.shared.birthday = self.birthdayPicker.date
        
        self.navigationController?.popToRootViewController(animated: true)
  
    }
    
    
    
    //'이전' 버튼 클릭 시.
    @IBAction func popToPrev() {
        
        //UserInformation에 정보 저장.
        UserInformation.shared.phoneNumber = self.phoneNumberField.text
    
        self.navigationController?.popViewController(animated: true)
    }
    
    //'취소' 버튼 클릭시.
    @IBAction func cancelSignUp() {
        
        //UserInformation 초기화.
        UserInformation.shared.deleteData()
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
