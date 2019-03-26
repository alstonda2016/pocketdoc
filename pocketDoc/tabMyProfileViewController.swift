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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
