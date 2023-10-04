//
//  ResultState.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 03/10/2023.
//

import Foundation


enum ResultState<T, String> {
    case loading
    case idle
    case success(T)
    case failure(String)
  
    
    var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
    var error: String? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    var isIdle: Bool {
        if case .idle = self {
            return true
        }
        return false
    }
    
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
    
    var isFailure: Bool {
        if case .failure = self {
            return true
        }
        return false
    }
    
}

struct ResultsState<T, U> {
    var isLoading: Bool = false
    var isSuccess: Bool = false
    var isFailure: Bool = false
    var value: T?
    var error: U?
    
    mutating func setLoading() {
        isLoading = true
        isSuccess = false
        isFailure = false
    }
    
    mutating func setSuccess(_ value: T) {
        isLoading = false
        isSuccess = true
        isFailure = false
        self.value = value
        self.error = nil
    }
    
    mutating func setFailure(_ error: U) {
        isLoading = false
        isSuccess = false
        isFailure = true
        self.value = nil
        self.error = error
    }
}

