//
//  tabMyProfileViewController.swift
//  pocketDoc
//
//  Created by David A on 3/26/19.
//  Copyright © 2019 DMA. All rights reserved.
//

import UIKit

class tabMyProfileViewController: UIViewController {
    @IBAction func btnAddMedicine(_ sender: Any) {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "addMedicineViewController") as! addMedicineViewController
        navigationController?.pushViewController(myVC, animated: true)
    }
    @IBAction func btnGoToSettings(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "settingsViewController") as! settingsViewController
        navigationController?.pushViewController(myVC, animated: true)
        
    }
    
    @IBAction func btnCallHospital(_ sender: Any) {
        guard let url = URL(string: "tel://\(2175558445)") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
