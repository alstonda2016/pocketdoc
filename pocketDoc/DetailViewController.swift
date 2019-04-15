/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class DetailViewController: UIViewController {
  
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var candyImageView: UIImageView!
    @IBOutlet weak var detailDescription: UITextView!
    @IBOutlet weak var actionBtn: UIButton!
    @IBAction func doAction(_ sender: Any) {
        switch detailCandy!.category {
        case Category.Hospital:
            dialNumber(number: "2173051108")
        case Category.Pharmacy:
            dialNumber(number: "2173051108")
        default:
            print("lol")
        }
    }
    
    var detailCandy: SearchOption? {
        didSet {
            configureView()
        }
    }
  
    func configureView() {
        if let detailCandy = detailCandy {
          if let detailDescriptionLabel = detailDescriptionLabel, let candyImageView = candyImageView, let detailDescription = detailDescription, let actionBtn = actionBtn {
            detailDescriptionLabel.font = UIFont(name: "Verdana-Bold", size: 20)
            detailDescriptionLabel.text = detailCandy.name
            
            candyImageView.image = UIImage(named: detailCandy.name)
            
            title = detailCandy.category.toString()
            
            detailDescription.isScrollEnabled = false
            detailDescription.font = UIFont(name: "Verdana", size: 16)
            detailDescription.text = detailCandy.description
            
            switch detailCandy.category {
                case Category.Hospital:
                    actionBtn.setTitle("Call", for: .normal)
                case Category.Pharmacy:
                    actionBtn.setTitle("Call", for: .normal)
                case Category.Medicine:
                    actionBtn.setTitle("Buy", for: .normal)
                case Category.Symptom:
                    actionBtn.setTitle("Remedies", for: .normal)
            }
          }
        }
    }
    
    func dialNumber(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

