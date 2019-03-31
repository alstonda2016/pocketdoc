//
//  viewDetailsViewController.swift
//  pocketDoc
//
//  Created by David A on 3/31/19.
//  Copyright © 2019 DMA. All rights reserved.
//

import UIKit

class viewDetailsViewController: UIViewController {
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBAction func btnExit(_ sender: Any) {
        
        removeAnimate()
    }
    
    var passedVal:calendarObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        showAnimate()
        
        viewBack.layer.cornerRadius = 12
        viewBack.clipsToBounds = true
        viewBack.layer.borderWidth = 2
        viewBack.layer.borderColor =  #colorLiteral(red: 0.3278279901, green: 0.3278364539, blue: 0.3278318942, alpha: 1)
        

        lblTitle.text = passedVal.medicineName
        lblDetails.text = passedVal.directions
        
        

    }
    

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
