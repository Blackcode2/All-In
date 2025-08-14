//
//  ProductListView.swift
//  AllIn
//
//  Created by KimDogyung on 8/13/25.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel: ProductListViewModel = ProductListViewModel()
    
    var body: some View {
        ScrollView {
            
            if viewModel.productList.isEmpty {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                } else {
                    ProgressView("상품 목록을 불러오는 중...")
                }
            } else {
                LazyVStack {
                    ForEach(viewModel.productList, id: \.id) { product in
                        makeProductRow(product)
                    }
                }
            }
        }
        .appPadding()
        .task {
            await viewModel.fetchAllProducts()
        }
    }
    
    
    private func makeProductRow(_ product: Product) -> some View {
        HStack {
            Text(product.product)
            Spacer()
            Text("\(product.price)")
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        
    }
    
}


#Preview {
    ProductListView()
}
