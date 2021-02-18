//
//  ViewController.swift
//  Flicker App
//
//  Created by Tatiana Podlesnykh on 16.2.2021.
//

import UIKit


class SearchViewController: UIViewController {
    
    private let viewModel = PhotosViewModel()
    private var photosList = [PhotoData]()
    
    private var testArray = [String:String]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    // MARK: - Get Data
    
    func getData() {
                
        viewModel.getPhotosList(search: "String") { (list) in
            DispatchQueue.main.async {
                if list.photo.count != 0 {
                    for photo in list.photo {
                        print(photo.id)
                        self.testArray[photo.id!] = "pencil"
                    }
                } else {
                    print("Error: failed to get restaurant list")
                }
            }
        }
        
    }
}

