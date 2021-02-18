//
//  Photo.swift
//  Flicker App
//
//  Created by Tatiana Podlesnykh on 18.2.2021.
//

import Foundation

struct PhotoData: Codable {
    //https://live.staticflickr.com/{server-id}/{id}_{secret}_{size-suffix}.jpg
    var id: String?
    var secret: String?
    var server: String?
    var title: String?
}

struct PhotoResponseData: Codable {
    var photo: [PhotoData]
}

struct PhotosRequestModel: Codable {
    var photos: PhotoResponseData
}
