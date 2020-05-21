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
        FontPicker.delegate = self
        FontPicker.dataSource = self
      
    }
    @IBAction func RturnSettngsTapped(_ sender: Any) {
    }
    
    
    @IBAction func FontSizeStepper(_ sender: UIStepper) {
        let x = CGFloat(sender.value)
        Share.shared.fontSize = Int(x)
       FontSizeLabel.font = UIFont.italicSystemFont(ofSize: x)
        Share.shared.FontChnaged = 1
    }
    
    @IBAction func NightMoodeTapped(_ sender: Any) {
        
        if NightModeTrigger.isOn == true
              {
                  SettingViewCard.backgroundColor = UIColor(named: "White Color")
              } else if NightModeTrigger.isOn == false
              {
                  SettingViewCard.backgroundColor = UIColor.red
              }
        
        
    }
    
    @IBAction func Save(_ sender: Any) {
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
        FontTypeLabel.font = UIFont(name: selectedFont ?? "Lateef", size: 30)
    }
}
