//
//  APIConstants.swift
//  Flicker App
//
//  Created by Tatiana Podlesnykh on 17.2.2021.
//

import Foundation

enum ApiConstants: CustomStringConvertible {
    
    case ApiKeyPrefix
    case ApiKey
    case NetworkPath
    case URLScheme
    case Host
    case Method
    case Format
    case Function
    case Search
    
    var description: String {
        
        switch self {
        
        case .ApiKeyPrefix:
            return "api_key"
        case .ApiKey:
            return "b59eaa142fbb03d0ba6c93882fd62e30"
        case .NetworkPath:
            return "/services/rest/"
        case .URLScheme:
            return "https"
        case .Host:
            return "api.flickr.com"
        case .Method:
            return "method"
        case .Format:
            return "format"
        case .Function:
            return "nojsoncallback"
        case .Search:
            return "text"
        }
    }
}
