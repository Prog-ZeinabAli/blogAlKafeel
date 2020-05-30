//
//  AddPostViewController.swift
//  blog
//
//  Created by turath alanbiaa on 5/3/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController {

    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var catBtn: UIButton!
    @IBOutlet weak var BlogContent: UITextView!
    @IBOutlet weak var BlogTitle: UITextField!
    @IBOutlet weak var BlogTags: UITextField!
    @IBOutlet weak var BlogImage: UIImageView!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    public var imagePickerController: UIImagePickerController?
    var catType = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Get.NightMode(from: self)
        tv.delegate = self
        tv.dataSource = self
        Loading.isHidden = true
                        
        
        if Share.shared.updatePost == 1{  //incase the user wants to edit post rathr tan making a new one
            BlogImage.isHidden = false
            BlogContent.text = Share.shared.content
            BlogTags.text = Share.shared.tag
            BlogTitle.text = Share.shared.title
            sendBtn.setTitle("تعديل" ,for: .normal)
            catBtn.setTitle("الاصناف : \(Share.shared.cat ?? "اخرى" )",for: .normal)
            
        }

        
    }
   
    
    @IBAction func CategoryBtnTapped(_ sender: Any) {
        tv.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            DataService.instance.fetchAllCategories { (success) in
                if success {
                    self.tv.reloadData()
                }
            }
        }
    
    
    @IBAction func sendPost(_ sender: Any) {
        sendBtn.isEnabled = false
        self.Loading.isHidden = false
        self.Loading.startAnimating()
        if BlogTags.text == "" && BlogContent.text == "" && BlogTitle.text == ""
        {
            let alert = UIAlertController(title: "خطأ", message: "تاكد من ملئ جميع الحقول اولا قبل الارسال", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            self.Loading.isHidden = true
            self.Loading.stopAnimating()
        }
        else
        {
        if Share.shared.updatePost == 1{
            Share.shared.updatePost == 0  // so next time when user want to pot it wont look like edit
            let title = BlogTitle.text
                   let content = BlogContent.text
                   let tag = BlogTags.text
            
            //update Post
            let json: [String: Any] = ["id": Share.shared.PostId ,"title": title,"content":content,"category_id": catType ,"image": "image.png","tags": tag, ]
            UpdatePostDataServer.instance.updatePost(json:json ) { [weak self] (response) in
                                                     if self == nil {return}
                                                      if response.success {
                                                        if let user = response.data {
                                                           if(user.message == "update DONE")
                                                         {
                                                            self!.Loading.isHidden = true
                                                            self!.Loading.stopAnimating()
                                                           let alert = UIAlertController(title: "تم التحديث", message: " لقد تم تحديت التدوينة بنجاح", preferredStyle: .alert)
                                                                                             alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                                                                             self!.present(alert, animated: true)
                                                            self!.sendBtn.isEnabled = true
                                                            self!.dismiss(animated: true, completion: nil)
                                                       }
                                                     }else {
                                                         let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                                         alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                                         self!.Loading.isHidden = true
                                                         self!.Loading.stopAnimating()
                                                     }
                                                 }
            }
            //Create new post
        } else {
        
        
        let title = BlogTitle.text ?? " "
        let content = BlogContent.text ?? " "
        let tag = BlogTags.text ?? " "
        let json: [String: Any] = ["user_id": 691311583402731,"title": title,"content":content,"tags": tag,"category_id": catType ,"input_img": "image.png" ]
        AddPostDateServer.instance.sendPost(json:json) { [weak self] (response) in
                        guard self != nil else { return }
                               if response.success {
                                self!.sendBtn.isEnabled = true
                        print(response)
                                let alert = UIAlertController(title: " تمت عملية الارسال", message:" لقد تم رفع التدوينة ، سيتم نشرها بعد الموافق", preferredStyle: .alert)
                                                              alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                                              self!.present(alert, animated: true)
                              //  self!.dismiss(animated: true, completion: nil)
                                self!.sendBtn.isEnabled = true
                                self!.Loading.isHidden = true
           }else {
                               let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                               alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                               self!.Loading.isHidden = true
                               self!.Loading.stopAnimating()
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
                BlogImage.isHidden = false
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

    extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
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


extension AddPostViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return DataService.instance.categories.count
    }
    
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
           cell.textLabel?.text = DataService.instance.categories[indexPath.row].categoryName
          return cell
      }
      
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
       {
        catBtn.setTitle("الاصناف : \(DataService.instance.categories[indexPath.row].categoryName ?? "اخرى" )",for: .normal)
         let x = DataService.instance.categories[indexPath.row].id ?? 0
        catType = x
            tableView.isHidden = true
        
       }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    
}


    
  


