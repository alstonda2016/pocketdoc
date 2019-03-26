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
    var foundation = [calendarObject]()
    //Name of the collectionView
    @IBOutlet weak var collectionList: UICollectionView!

    
    //gives # of items in the colelctionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //returns # of items in the array
        return foundation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  let cell:tabHomeCalendarCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabHomeCalendarCollectionViewCell", for: indexPath) as! tabHomeCalendarCollectionViewCell
        //Assigns the names/dates to lists
        cell.lblWeekDate.text = foundation[indexPath.row].calendarDate
        cell.lblMedicineName.text = foundation[indexPath.row].medicineName

        
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //I just added this to make sure it works
        foundation.append(calendarObject( medicineID:"AB3464HD",
                                          calendarDate:"MONDAY",
                                          medicineName:"XANEX" ))
        foundation.append(calendarObject( medicineID:"AB3464HD",
                                          calendarDate:"TUESDAY",
                                          medicineName:"XANEX" ))
        
            foundation.append(calendarObject( medicineID:"AB3464HD",
                                              calendarDate:"WEDNESDAY",
                                              medicineName:"XANEX" ))
                foundation.append(calendarObject( medicineID:"AB3464HD",
                                                  calendarDate:"THURSDAY",
                                                  medicineName:"XANEX" ))
                    foundation.append(calendarObject( medicineID:"AB3464HD",
                                                      calendarDate:"FRIDAY",
                                                      medicineName:"XANEX" ))
        
        
        
        
        
        self.collectionList.reloadData()

        
        
        
        
        
    }
    

 

}
