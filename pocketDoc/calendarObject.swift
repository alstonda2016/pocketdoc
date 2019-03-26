//
//  calendarObject.swift
//  pocketDoc
//
//  Created by David A on 3/26/19.
//  Copyright © 2019 DMA. All rights reserved.
//

import Foundation
class calendarObject {
    var medicineID:String = ""
    var calendarDate:String = ""
    var medicineName:String = ""
    
    
    
    
    
    
    //Normal Post
    init( medicineID:String,
          calendarDate:String,
          medicineName:String ) {
        self.medicineID = medicineID
        self.calendarDate = calendarDate
        self.medicineName = medicineName
        
    }
    
    
    
    func toFBObject() -> Any {
        return [
            "medicineID":medicineID as AnyObject,
            "calendarDate":calendarDate as AnyObject,
            "medicineName": medicineName as AnyObject
        ]
        
    }
    
    
    
    
}
