//
//  Photo.swift
//  Flicker App
//
//  Created by Tatiana Podlesnykh on 18.2.2021.
//

import Foundation

struct PhotoData: Codable {
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
