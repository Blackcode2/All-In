//
//  ProductListViewModel.swift
//  AllIn
//
//  Created by KimDogyung on 8/14/25.
//

import SwiftUI


@MainActor
class ProductListViewModel: ObservableObject {
    @Published var productList: [Product] = []
    @Published var errorMessage: String?

    private let networkService = NetworkService()
        
    func fetchAllProducts() async {
        if let fetchedProducts = await networkService.fetchAllProducts() {
            
            self.productList = fetchedProducts
        } else {
            
            self.errorMessage = "상품 목록을 불러오는 데 실패했습니다."
        }
    }
    
}
