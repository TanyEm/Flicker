//
//  PhotosViewModel.swift
//  Flicker App
//
//  Created by Tatiana Podlesnykh on 18.2.2021.
//

import Foundation

class PhotosViewModel {
    
    var list = [PhotoData]()
    
    func getPhotosList(search: String, callback: @escaping (_ result: [PhotoData])->()) {
        let request = NetworkManager()
        
        request.getPhotosList(search: search) { (result) in            
            DispatchQueue.main.async {
                if result.photo.count != 0 {
                    for photo in result.photo {
                        self.list.append(PhotoData(id: photo.id, secret: photo.secret, server: photo.server, title: photo.title))
                    }
                    callback(self.list)
                } else {
                    callback(self.list)
                    print("Error: failed to get restaurant list")
                }
            }
        }
    }
    
    func getImageURLByID(id: String?) -> String {
        var url: String = ""
        
        for item in list {
            if id == item.id {
                if let server = item.server,
                   let id = item.id,
                   let secret = item.secret {
                    url = "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg"
                }
            }
        }
        return url
    }
    
}
