//
//  NetworkService.swift
//  AllIn
//
//  Created by KimDogyung on 8/13/25.
//

import Alamofire
import Foundation



public class NetworkService {
    let baseUrl = "https://" + ApiKeyManager.apiKey + "." + ApiKeyManager.baseURL
    public init() {}
    
    
    func createProduct(product: Product) async -> Product? {
        let url = baseUrl + "/proudct"
        
        
        do {
            
            let response = try await AF.request(url, method: .post, parameters: product, encoder: JSONParameterEncoder.default)
                .validate()
                .serializingDecodable(Product.self)
                .value
            
            
            return response
            
        } catch {
            print("Error creating post: \(error.localizedDescription)")
            return nil
        }
        
    }
    
    func fetchProduct(id: Int) async -> Product? {
        let url = baseUrl + "/proudct" + "/\(id)"
        
        do {
            let product = try await AF.request(url).validate().serializingDecodable(Product.self).value
            
            return product
        } catch {
            print("Error fetching post: \(error.localizedDescription)")
            return nil
        }
        
    }
    
    func fetchAllProducts() async -> [Product]? {
        let url = baseUrl + "/proudct"
        
        do {
            let products = try await AF.request(url).validate().serializingDecodable([Product].self).value
            
            return products
        } catch {
            print("Error fetching posts: \(error.localizedDescription)")
            return nil
        }
    }
    
    func updateProduct(id: Int, product: Product) async -> Product? {
        let url = baseUrl + "/proudct" + "/\(id)"
        
        do {
            let response = try await AF.request(url, method: .put, parameters: product, encoder: JSONParameterEncoder.default)
                .validate()
                .serializingDecodable(Product.self)
                .value
            
            return response
        } catch {
            print("Error updating post: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    func deleteProduct(id: Int) async -> Bool {
        let url = baseUrl + "/proudct" + "/\(id)"
        do {
            // DELETE 요청을 보냅니다.
            _ = try await AF.request(url, method: .delete)
                .validate()
                .serializingData() // 성공 여부만 중요하므로 Data로 받습니다.
                .value
            
            // 성공적인 응답(2xx)이 오면 성공으로 간주합니다.
            return true
        } catch {
            print("Error deleting post: \(error.localizedDescription)")
            return false
        }
    }
    
    
}
