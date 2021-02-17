//
//  NetworkManager.swift
//  Flicker App
//
//  Created by Tatiana Podlesnykh on 17.2.2021.
//

import Foundation
import Combine

protocol ApiConfiguration {
    
    var apiKey: String { get }
    var path: String { get }
}

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
    
    private init() {}
    
    private var urlComponents: URLComponents =  {
        var component = URLComponents()
        component.scheme = ApiConstants.URLScheme.description
        component.host = ApiConstants.Host.description
        
        component.queryItems = [
                URLQueryItem(name: ApiConstants.Method.description, value: "flickr.photos.search"),
            ]
        
        return component
        
    }()
    
}

extension NetworkManager: ApiConfiguration {
    
    internal var apiKey: String {
        return ApiConstants.ApiKey.description
    }
    
    internal var path: String {
        return ApiConstants.NetworkPath.description
    }
    
    func sendRequest(search: String, method: RequestMethod = .get) -> AnyPublisher<XMLParser, Error>  {
        
        var innerUrl = urlComponents
        var urlQueryItem: [URLQueryItem] = []
        urlQueryItem.append(.init(name:ApiConstants.Search.description, value: search))
        innerUrl.queryItems = urlQueryItem
        
        guard let url = innerUrl.url else {
            return Empty().eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)

        request.httpMethod = method.description

        
            
        return URLSession.shared.dataTaskPublisher(for: request).tryMap { (element) -> Data in
            
            guard let response = element.response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.InvalidURL
            }
        
            return element.data
            
        }.map { (data) -> XMLParser in
           
            print(data)
            return XMLParser(data: data)
            
        }.eraseToAnyPublisher()
    }
}
