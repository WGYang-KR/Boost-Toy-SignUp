//
//  SiginUpFirstViewController.swift
//  SignUp
//
//  Created by WG Yang on 2022/02/18.
//

import UIKit

class SiginUpFirstViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet var textField_ID: UITextField!
    @IBOutlet var textField_Password: UITextField!
    @IBOutlet var textField_CheckPassword: UITextField!
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var textView_aboutMe: UITextView!
    
    //image picker
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true //이미지 crop 기능 켜기
        picker.delegate = self
        return picker
    }()
    
    
    //배경클릭 시
    @objc func backgroundTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        checkValid()
        //키보드 사라지게
        self.view.endEditing(true)
    }
    
    //프로필 사진 클릭 시
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //이미지피커 호출
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    //선택된 사진 뷰에 지정
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.photoView.image = editedImage
            UserInformation.shared.photo = editedImage
            UserInformation.shared.photoDidChanged = true
        }
        self.checkValid()
        self.dismiss(animated: true, completion: nil)
    }
    
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
        
        self.checkValid()
        
    }
    //텍스트 뷰 입력값 변하면 유효성 검사
    @objc func TVdidChanged(_ sender: UITextView) {
        self.checkValid()
    }
   
    //ID,PW,사진,소개글이 다 채워졌는지.
    func checkValid() {
        //3개 텍스트필드가 채워졌는지, 비밀번호가 일치하는 지 확인.
        if !(self.textField_ID.text?.isEmpty ?? true) //ID
            && !(self.textField_Password.text?.isEmpty ?? true) //PW
            && isSameBothTextField(textField_Password, textField_CheckPassword) //PW와 PW_CHECK 일치여부
            && !(self.textView_aboutMe.text.isEmpty ) //소개글
            && UserInformation.shared.photoDidChanged == true //프로필 사진
        {
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
            self.nextButton.addTarget(self, action: #selector(pushToNext(_:)), for: UIControl.Event.touchUpInside)
            
            
        } else {
            //다음 버튼 색 변경
            self.nextButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            //다음 페이지 연결 해제
            print("다음 버튼 비활성화")
            self.nextButton.removeTarget(self, action: #selector(pushToNext(_:)), for: .touchUpInside)
        }
    }
    
    @objc func pushToNext(_ sender: Any?) {

        //UserInformation에 정보저장.
        UserInformation.shared.id = self.textField_ID.text
        UserInformation.shared.password = self.textField_Password.text
        UserInformation.shared.aboutMe = self.textView_aboutMe.text
        UserInformation.shared.photo = self.photoView.image
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSecondVC") else{print("다음 VC를 찾을 수 없음"); return}
        
            self.navigationController?.pushViewController(nextVC, animated: true)
  
        
    }
    
    //'취소' 버튼 클릭시.
    @IBAction func cancelSignUp() {
        
        //UserInformation 초기화.
        UserInformation.shared.deleteData()
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.textField_ID.delegate = self
        self.textField_Password.delegate = self
        self.textField_CheckPassword.delegate = self
        self.textView_aboutMe.delegate = self
        
        //텍스트필드 입력값 변경 감지
        self.textField_ID.addTarget(self, action: #selector(self.TFdidChanged(_:)), for: .editingChanged)
        self.textField_Password.addTarget(self, action: #selector(self.TFdidChanged(_:)), for: .editingChanged)
        self.textField_CheckPassword.addTarget(self, action: #selector(self.TFdidChanged(_:)), for: .editingChanged)
        //텍스트뷰 입력값 변경 감지
        //self.textView_aboutMe.refreshControl?.addTarget(self, action: #selector(TVdidChanged(_:)), for: .editingChanged)
        self.textView_aboutMe.refreshControl?.addTarget(self, action: #selector(TVdidChanged(_:)), for: .allEditingEvents)
        
        let tapPhotoViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        photoView.isUserInteractionEnabled = true
        photoView.addGestureRecognizer(tapPhotoViewRecognizer)
        
        let tapBackgroundGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(tapGestureRecognizer:)))
        view.addGestureRecognizer(tapBackgroundGestureRecognizer)
                                                                    
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
