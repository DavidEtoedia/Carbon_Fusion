//
//  Errors.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 27/07/2023.
//

import Foundation

enum ApiError : Error {
    case DecodingError
    case EncodingError
    case URLError
    case errorCode(Int)
    case unknown
}

    extension ApiError : LocalizedError {
        var errorDescription: String? {
            switch self{
            case.DecodingError:
                return "An Error occurred While Decoding"
            case.errorCode( let code):
                return handleError(statusCode: code)
            case .unknown:
                return "an Unknown Error occurred"
            case .EncodingError:
                return "An Error occurred While Encoding"
            case .URLError:
                return "Check the url if that is correct"
            }
        }
        
        
        
        func handleError(statusCode:  Int) -> String {
            switch (statusCode) {
            case 400:
                return "Bad request";
            case 401:
                return "Unauthorized";
            case 403:
                return "Forbidden response";
            case 404:
                return "requested page is not available";
            case 500:
                return "Internal server error";
            case 502:
                return "Bad gateway";
            case 503:
                return "Service unavailable. Please try again later";
            case 422:
                return "An error occurred .. Please try again";
            case 429:
                return "Too many request ";
            default:
                return "Oops something went wrong";
            }
        }
    }







