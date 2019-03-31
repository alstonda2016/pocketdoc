//
//  tabHomeCalendarViewController.swift
//  pocketDoc
//
//  Created by David A on 3/26/19.
//  Copyright © 2019 DMA. All rights reserved.
//

import UIKit

class tabHomeCalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UITabBarControllerDelegate,  UIPopoverPresentationControllerDelegate, CAAnimationDelegate {
    //Array of calendar objects
    
    @IBAction func btnReload(_ sender: Any) {
        self.collectionList.reloadData()

    }
    @IBAction func btnGTAdd(_ sender: Any) {
        
        
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "addMedicineViewController") as! addMedicineViewController
        
      //  self.navigationController?.pushViewController(myVC, animated: true)
        
        
      
        
     
        present(savingsInformationViewController, animated: true, completion: nil)
        
        
        
        
    }
    //Name of the collectionView
    @IBOutlet weak var collectionList: UICollectionView!

    
    //gives # of items in the colelctionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //returns # of items in the array
        return ModelData.shared.foundation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  let cell:tabHomeCalendarCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabHomeCalendarCollectionViewCell", for: indexPath) as! tabHomeCalendarCollectionViewCell
        //Assigns the names/dates to lists
        cell.lblWeekDate.text = ModelData.shared.foundation[indexPath.row].calendarDate
        cell.lblMedicineName.text = ModelData.shared.foundation[indexPath.row].medicineName
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8;
    cell.layer.borderColor =  #colorLiteral(red: 0.289869281, green: 0.2431372549, blue: 0.8039215686, alpha: 1)
        cell.layer.borderWidth = 1
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "viewDetailsViewController") as! viewDetailsViewController
        
        //  self.navigationController?.pushViewController(myVC, animated: true)
        
        
        savingsInformationViewController.passedVal = ModelData.shared.foundation[indexPath.row]
        
        
        present(savingsInformationViewController, animated: true, completion: nil)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //I just added this to make sure it works
        ModelData.shared.foundation.append(calendarObject( medicineID:"AB3464HD",
                                          calendarDate:"MONDAY",
                                          medicineName:"XANEX", directions:"take 3"  ))
        ModelData.shared.foundation.append(calendarObject( medicineID:"AB3464HD",
                                          calendarDate:"TUESDAY",
                                          medicineName:"XANEX" , directions:"take 3" ))
        
            ModelData.shared.foundation.append(calendarObject( medicineID:"AB3464HD",
                                              calendarDate:"WEDNESDAY",
                                              medicineName:"XANEX", directions:"take 3"  ))
                ModelData.shared.foundation.append(calendarObject( medicineID:"AB3464HD",
                                                  calendarDate:"THURSDAY",
                                                  medicineName:"XANEX", directions:"take 3"  ))
                    ModelData.shared.foundation.append(calendarObject( medicineID:"AB3464HD",
                                                      calendarDate:"FRIDAY",
                                                      medicineName:"XANEX" , directions:"take 3" ))
        
        
        
        
        
        self.collectionList.reloadData()

        
        
        
        
        
    }
    

 

}

class ModelData: NSObject {
    static let shared: ModelData = ModelData()
    var name = "Fred"
    var age = 50
    var foundation = [calendarObject]()
}
