//
//  Paginator.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 06.01.26.
//

import Foundation
import Combine

@MainActor
final class Paginator<T: Identifiable & Equatable> {
    @Published private(set) var items: [T] = []
    @Published private(set) var isLoading = false
    
    private var currentPage = 1
    private var canLoadMore = true
    private let thresholdOffset: Int
    
    private let fetchPage: (Int) async throws -> [T]
    
    init(thresholdOffset: Int = 5, fetchPage: @escaping (Int) async throws -> [T]) {
        self.thresholdOffset = thresholdOffset
        self.fetchPage = fetchPage
    }
    
    func loadInitial() async {
        guard items.isEmpty else { return }
        await loadNextPage()
    }
    
    func checkAndLoadMore(currentItem: T?) async {
        guard let currentItem else {
            await loadNextPage()
            return
        }
        
        let thresholdIndex = items.index(items.endIndex, offsetBy: -thresholdOffset)
        if items.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            await loadNextPage()
        }
    }
    
    func loadNextPage() async {
        guard canLoadMore, !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let newItems = try await fetchPage(currentPage + 1)
            
            if newItems.isEmpty {
                canLoadMore = false
            } else {
                items.append(contentsOf: newItems)
                currentPage += 1
            }
        } catch {
            canLoadMore = false
            print("Failed to load page \(currentPage + 1): \(error)")
        }
    }
    
    func reset() {
        items.removeAll()
        currentPage = 1
        canLoadMore = true
    }
}
