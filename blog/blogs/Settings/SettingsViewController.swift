//
//  SettingsViewController.swift
//  blog
//
//  Created by turath alanbiaa on 4/29/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class SettingsViewController : UIViewController  {
    
    let fonts = ["Al-Jazeera-Arabic","Aref Ruqaa","Lateef"]
    var selectedFont : String?
    @IBOutlet weak var FontTypeLabel: UILabel!
    
    @IBOutlet weak var NightModeTrigger: UISwitch!
    @IBOutlet weak var SettingViewCard: CardShadow!
    @IBOutlet weak var FontPicker: UIPickerView!
    @IBOutlet weak var FontSizeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:- standard font size
        if ( UserDefaults.standard.object(forKey: "FontSizeDefault") != nil){
        FontSizeLabel.font = UIFont.italicSystemFont(ofSize: (UserDefaults.standard.object(forKey: "FontSizeDefault") as! CGFloat) ?? 13 )
        } else{
        FontSizeLabel.font = UIFont.italicSystemFont(ofSize: 13) //default value
            }
        
           //MARK:- standard NightMode
        if UserDefaults.standard.object(forKey: "NightMode")as? String == "True"
               {
                overrideUserInterfaceStyle = .dark
                      NightModeTrigger.isOn = true
               }else{
                    NightModeTrigger.isOn = false
            overrideUserInterfaceStyle = .light
               }
        
        
        FontPicker.delegate = self
        FontPicker.dataSource = self
        
        
        
        
      
    }
    @IBAction func RturnSettngsTapped(_ sender: Any) {
          FontSizeLabel.font = UIFont.italicSystemFont(ofSize: 13)
          NightModeTrigger.isOn = false
          overrideUserInterfaceStyle = .light
          FontTypeLabel.font = UIFont(name: selectedFont ?? "Lateef", size: 30)
           selectedFont = fonts[0]
        
        
    }
    
    
    @IBAction func FontSizeStepper(_ sender: UIStepper) {
        let x = CGFloat(sender.value)
        UserDefaults.standard.set(x, forKey: "FontSizeDefault")
        FontSizeLabel.font = UIFont.italicSystemFont(ofSize: x)
        Share.shared.FontChnaged = 1
    }
    
    @IBAction func NightMoodeTapped(_ sender: Any) {
        if NightModeTrigger.isOn == true
              {
                  overrideUserInterfaceStyle = .dark
                  UserDefaults.standard.set("True", forKey: "NightMode")
             
              } else if NightModeTrigger.isOn == false
              {
                   overrideUserInterfaceStyle = .light
                UserDefaults.standard.set("False", forKey: "NightMode")
              }
        
        
    }
    
    @IBAction func Save(_ sender: Any) {
      //  guard let menuViewController = self.storyboard?.instantiateViewController(identifier: "MenuViewControlller") else {return}
                                      self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
       // UIApplication.shared.keyWindow?.rootViewController = BlogViewController()
        dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController : UIPickerViewDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fonts.count
    }
}

extension SettingsViewController :  UIPickerViewDataSource
{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fonts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      selectedFont = fonts[row]
        let FT = UserDefaults.standard.set(selectedFont , forKey: "FontTypeDefault")
        FontTypeLabel.font = UIFont(name: selectedFont ?? "Lateef", size: 30)
    }
}
