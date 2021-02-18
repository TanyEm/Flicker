//
//  PhotosViewModel.swift
//  Flicker App
//
//  Created by Tatiana Podlesnykh on 18.2.2021.
//

import Foundation

class PhotosViewModel {
    
    var list = [PhotoData]()
    
    func getPhotosList(search: String, callback: @escaping (_ result: PhotoResponseData)->()) {
        let request = NetworkManager()
        
        request.getPhotosList(search: "String") { (result) in
            print(result.photo)
            
            DispatchQueue.main.async {
                if result.photo.count != 0 {
                    for photo in result.photo {
                        print(photo.id)
                    }
                    print(result)
                } else {
                    print("Error: failed to get restaurant list")
                }
            }

            
        }

    }
}
