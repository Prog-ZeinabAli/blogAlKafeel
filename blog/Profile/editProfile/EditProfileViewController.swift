//
//  EditProfileViewController.swift
//  blog
//
//  Created by turath alanbiaa on 4/28/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    var User_id = UserDefaults.standard.object(forKey: "loggesUserID")
    @IBOutlet weak var uiView: CardShadow!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var OkBtn: UIButton!
    @IBOutlet weak var CnclBtn: UIButton!
    @IBOutlet weak var ChooseBtn: UIButton!
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    public var imagePickerController: UIImagePickerController?
    
    
    override func viewDidLoad() {
        self.Loading.isHidden = true
        self.Loading.stopAnimating()
        
        
        Utilities.TitlefadedColor(uiView)
        Utilities.styleHollowButton(CnclBtn)
        Utilities.styleHollowButton(OkBtn)
         Utilities.styleHollowButton(ChooseBtn)
             super.viewDidLoad()
             self.selectedImageView.contentMode = .scaleAspectFill
             self.selectImageButton.isEnabled = self.selectedImage == nil
             self.selectImageButton.alpha = 1
         }
    
    
    
      @IBAction func Cancel(_ sender: Any) {
          dismiss(animated: true, completion: nil)
      }
    
    @IBAction func Save(_ sender: Any) {
        
        self.Loading.isHidden = false
                    self.Loading.startAnimating()
        if userName.text?.isEmpty == true{
            let alert = UIAlertController(title: "خطأ", message:" تأكد من ملئ جميع الحقول ", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
             self.present(alert, animated: true)
        }else {
        let json: [String: Any] = ["id": 691311583402731 ,"name":userName.text,"picture":"image.png" ]//Share.shared.userId as Any]//
        UpdtProfileDataServer.instance.Updating(json:json ) { [weak self] (response) in
                                        if self == nil {return}
                                         if response.success {
                                            self!.dismiss(animated: true, completion: nil)
                                            self!.Loading.isHidden = true
                                            self!.Loading.stopAnimating()
                                            let alert = UIAlertController(title: "خطأ", message: "updated", preferredStyle: .alert)
                                                                                                                          alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                                                                                                          self!.present(alert, animated: true)
                                            
                                           if let user = response.data {
                                              if(user.message == "update DONE")
                                            {
                                                print("yes")
                                              
                                            
                                          }
                                        }else {
                                            let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                            self!.present(alert, animated: true)
                                        }
                                    }
          }
        }
    }
    
    
    
    //adding image

       internal var selectedImage: UIImage? {
           get {
               return self.selectedImageView.image
           }
           
           set {
               switch newValue {
               case nil:
                   self.selectedImageView.image = nil
                   self.selectImageButton.isEnabled = true
                   self.selectImageButton.alpha = 1
                   
                   self.removeImageButton.isEnabled = false
                   self.removeImageButton.alpha = 0.5
               default:
                   self.selectedImageView.image = newValue
                   self.selectImageButton.isEnabled = false
                   self.selectImageButton.alpha = 0.5
                   
                   self.removeImageButton.isEnabled = true
                   self.removeImageButton.alpha = 1
               }
           }
       }
    
       @IBOutlet weak var selectedImageView: UIImageView!
       
       @IBOutlet weak var selectImageButton: UIButton! {
           didSet {
               guard let button = self.selectImageButton else { return }
               button.isEnabled = true
               button.alpha = 1
           }
       }
       
       @IBOutlet weak var removeImageButton: UIButton! {
           didSet {
               guard let button = self.removeImageButton else { return }
               button.isEnabled = false
               button.alpha = 0.5
           }
       }

       @IBAction func selectImageButtonAction(_ sender: UIButton) {
           /// present image picker
           
           if self.imagePickerController != nil {
               self.imagePickerController?.delegate = nil
               self.imagePickerController = nil
           }
           
           self.imagePickerController = UIImagePickerController.init()
           
           let alert = UIAlertController.init(title: "اختر صورتك الشخصية", message: nil, preferredStyle: .actionSheet)
           
           if UIImagePickerController.isSourceTypeAvailable(.camera) {
               alert.addAction(UIAlertAction.init(title: "Camera", style: .default, handler: { (_) in
                   self.presentImagePicker(controller: self.imagePickerController!, source: .camera)
               }))
           }
           
           if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
               alert.addAction(UIAlertAction.init(title: "مكتبة الصور", style: .default, handler: { (_) in
                   self.presentImagePicker(controller: self.imagePickerController!, source: .photoLibrary)
               }))
           }
           
           if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
               alert.addAction(UIAlertAction.init(title: "البوم الصور", style: .default, handler: { (_) in
                   self.presentImagePicker(controller: self.imagePickerController!, source: .savedPhotosAlbum)
               }))
           }
           alert.addAction(UIAlertAction.init(title: "الغاء", style: .cancel))
           
           self.present(alert, animated: true)
           
       }
       
       internal func presentImagePicker(controller: UIImagePickerController , source: UIImagePickerController.SourceType) {
           controller.delegate = self
           controller.sourceType = source
           self.present(controller, animated: true)
       }
       
       @IBAction func removeImageButtonAction(_ sender: UIButton) {
           self.selectedImage = nil
       }
       
   }


   extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           
           guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
               return self.imagePickerControllerDidCancel(picker)
           }
           
           self.selectedImage = image
           
           picker.dismiss(animated: true) {
               picker.delegate = nil
               self.imagePickerController = nil
           }
           
       }
       
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true) {
               picker.delegate = nil
               self.imagePickerController = nil
           }
       }
       
   }


