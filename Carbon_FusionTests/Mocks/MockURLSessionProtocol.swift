//
//  MockURLSessionProtocol.swift
//  Carbon_FusionTests
//
//  Created by Inyene Etoedia on 14/08/2023.
//


#if DEBUG

import Foundation

class MockURLSessionProtocol: URLProtocol {
    
    static var loadingHandler: (() -> (HTTPURLResponse, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        guard let handler = MockURLSessionProtocol.loadingHandler else {
            fatalError("Loading handler is not set.")
        }
        
        let (response, data) = handler()
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}
#endif



// URLSession with completion handler


/*
class MocksURLSessionProtocol: URLProtocol {
    
    static var loadingHandler: ((URLRequest, @escaping (HTTPURLResponse, Data?) -> Void) -> Void)?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        guard let handler = MocksURLSessionProtocol.loadingHandler else {
            fatalError("Loading handler is not set.")
        }
        
        handler(request) { response, data in
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let data = data {
                self.client?.urlProtocol(self, didLoad: data)
            }
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {
        // Implementation for stopping loading if needed
    }
}
 
 */





