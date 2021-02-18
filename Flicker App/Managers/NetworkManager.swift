//
//  NetworkManager.swift
//  Flicker App
//
//  Created by Tatiana Podlesnykh on 17.2.2021.
//

import Foundation
import Combine


enum NetworkError: String, Error {
    case InvalidURL = "The url is invalid."
    case InvalidResponse = "The response is invalid."
    case InvalidData = "The data is invalid."
    case XMLError = "The xml is invalid."
}

enum RequestMethod: CustomStringConvertible {
    case get
    case post
    case put
    case patch
    case delete
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        }
    }
}

struct NetworkManager {
    
    static let shared = NetworkManager()
            
    private var urlComponents: URLComponents =  {
        var component = URLComponents()
        component.scheme = ApiConstants.URLScheme.description
        component.host = ApiConstants.Host.description
        component.path = ApiConstants.NetworkPath.description
        
        component.queryItems = [
            URLQueryItem(name: ApiConstants.Method.description, value: "flickr.photos.search"),
            URLQueryItem(name: ApiConstants.ApiKeyPrefix.description, value: ApiConstants.ApiKey.description),
            URLQueryItem(name: ApiConstants.Format.description, value: "json"),
            URLQueryItem(name: ApiConstants.Function.description, value: "1")
        ]
        
        return component
        
    }()
    
    func getPhotosList(search: String, callback: @escaping (_ result: PhotoResponseData)->()) {
        
        var innerUrl = urlComponents
        var urlQueryItem: [URLQueryItem] = []
        urlQueryItem.append(.init(name:ApiConstants.Search.description, value: search))
        innerUrl.queryItems?.append(contentsOf: urlQueryItem)

        guard let url = innerUrl.url else { return }
        
        print("URL: ", url)
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get.description
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("error=\(String(describing:error))")
                return
            }

            do {
                let resp = try JSONDecoder().decode(PhotosRequestModel.self, from: data!)
                callback(resp.photos)
                } catch {
                    print("Error while decoding the response", error)
                }
            }
        task.resume()
    }
    
}
