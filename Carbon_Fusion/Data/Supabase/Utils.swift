//
//  Utils.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 28/07/2023.
//

import Foundation


extension URL {
    static func supaBaseUrl() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dzdaoqpmncbxxnbotvmz.supabase.co"
        guard let thisUrl = components.url else{return URL(string: "")! }
        return thisUrl
    }
}

var apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR6ZGFvcXBtbmNieHhuYm90dm16Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTA1ODkzMjgsImV4cCI6MjAwNjE2NTMyOH0.8eWAdhTJ3ZTHQg9oXIVnNdglawBnU7h_a9SUfLtwPlQ"
