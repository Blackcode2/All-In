//
//  ApiKeyManager.swift
//  AllIn
//
//  Created by KimDogyung on 8/13/25.
//

import Foundation

struct ApiKeyManager {
    static var apiKey: String {
        // Info.plist에서 값을 가져옵니다.
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("Info.plist에서 API_KEY를 찾을 수 없습니다.")
        }
        return key
    }
    
    static var baseURL: String {
        guard let baseURl = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("Info.plist에서 BASE_URL를 찾을 수 없습니다.")
        }
        return baseURl
    }
}
