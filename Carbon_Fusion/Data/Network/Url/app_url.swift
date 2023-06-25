//
//  app_url.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 24/05/2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    // Add more methods as needed
}

extension String {
    func transformCase(_ stringCase: HTTPMethod) -> String {
        switch stringCase {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "PUT"
        }
    }
}

enum Direction {
    case north
    case south
    case east
    case west
}

extension Direction {
    var opposite: Direction {
        switch self {
        case .north:
            return .south
        case .south:
            return .north
        case .east:
            return .west
        case .west:
            return .east
        }
    }
    
    func description() -> String {
        switch self {
        case .north:
            return "Heading North"
        case .south:
            return "Heading South"
        case .east:
            return "Heading East"
        case .west:
            return "Heading West"
        }
    }
}

extension String{
    enum HTTPMethod: String  {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}

//extension URLRequest.HTTPMethod {
//    var errorDescription: String? {
//        switch self {
//        case .post:
//            return "POST"
//        case .delete:
//            return "DELETE"
//        case .get:
//            return "GET"
//        case .put:
//            return "PUT"
////        default:
////            return "Unknown"
//        }
//    }
//
//}



// GENERIC API ENDPOINTS WITH REQUEST
extension URL {
    
    func createAuthorizedURLComponents(host: String, path: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.carboninterface.com"
        urlComponents.path = path
    //
    //    if let parameters = queryParameters {
    //        var queryItems = [URLQueryItem]()
    //        for (key, value) in parameters {
    //            let queryItem = URLQueryItem(name: key, value: "\(value)")
    //            queryItems.append(queryItem)
    //        }
    //        urlComponents.queryItems = queryItems
    //    }
        
        // Add Authorization header
        urlComponents.percentEncodedQuery = "Authorization=\(ApiKey.apiKey.description)"
        
        return urlComponents.url
    }

    
   
}

extension URLRequest{
    static func urlRequest( _ method : HTTPMethod, data : Data ) -> URLRequest {
        let newUrl = createAuthorizedURLComponents()!
        var request = URLRequest(url: newUrl)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.setValue("Bearer \(ApiKey.apiKey.description)", forHTTPHeaderField: "Authorization")
        request.httpBody = data
        return request
    }

    
}

func createAuthorizedURLComponents() -> URL? {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "www.carboninterface.com"
    urlComponents.path = "/api/v1/estimates"
   // urlComponents.percentEncodedQuery = "Authorization=Bearer\(ApiKey.apiKey.description)"
    
    return urlComponents.url
}
