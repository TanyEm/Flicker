//
//  ViewController.swift
//  Flicker App
//
//  Created by Tatiana Podlesnykh on 16.2.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var list = [PhotoResponseData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let request = NetworkManager()
        
        request.getPhotosList(search: "String") { (result) in            
            DispatchQueue.main.async {
                if result.photo.count != 0 {
                    for photo in result.photo {
                        print(photo.id)
                    }
                } else {
                    print("Error: failed to get restaurant list")
                }
            }

            
        }

        

    }


}
