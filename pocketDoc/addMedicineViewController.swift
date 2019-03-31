//
//  addMedicineViewController.swift
//  pocketDoc
//
//  Created by David A on 3/26/19.
//  Copyright © 2019 DMA. All rights reserved.
//

import UIKit

class addMedicineViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var strDay = "SUNDAY"
    
    @IBOutlet weak var viewBack: UIView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]

    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        strDay = pickerData[row]
    }
    
    var pickerData: [String] = [String]()

    @IBOutlet weak var picker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        showAnimate()

        viewBack.layer.cornerRadius = 12
        viewBack.clipsToBounds = true
        viewBack.layer.borderWidth = 2
        viewBack.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)
        
        
        pickerData = ["SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"]
    
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var txtDescription: UITextView!
    @IBAction func btnAdd(_ sender: Any) {
        
        
        ModelData.shared.foundation.append(calendarObject( medicineID:"1234",
                                                           calendarDate: strDay,
                                                           medicineName: txtTitle.text! , directions: txtDescription.text!))
        
        removeAnimate()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        
        self.dismiss(animated: true, completion: nil)
        
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }

}
