//
//  ViewModel.swift
//  CodeChallenge
//
//  Created by Fabrizio Prosperi on 26/02/2022.
//

import Foundation
import Combine

class AdViewModel: ObservableObject {
   
    // MARK: - State
    enum State {
        case isLoading
        case failed(NetworkError)
        case loaded(Ad?)
    }
    
    // MARK: - Public
    var id: String {
        return "ID: \(ad?.id ?? "N/A")"
    }
    
    var smallImageViewURLs: [URL] {
        guard let pictures = ad?.pictures else {
            let arr = [URL]()
            return arr
        }
        let arr: [URL] = pictures.map { str in
            let urlString = str.replacingOccurrences(of: "_{imageId}", with: "_1")
            return URL(string: urlString) ?? URL(string: "")!
        }
        return arr
    }
    
    var title: String {
        return ad?.title ?? "N/A"
    }
    
    var amount: String {
        let currency = ad?.price?.currency ?? "N/A"
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        let amount = ad?.price?.amount ?? 0
        let formattedString = formatter.string(for: amount)
        return String(describing: formattedString ?? "")  + " " + currency 
    }
    
    var location: String {
        if let street = ad?.address?.street,
           let zip = ad?.address?.zipCode,
           let city = ad?.address?.city {
            return "\(street), \(zip) \(city)"
        }
        return "N/A"
    }
    
    var date: String {
        guard let dateTime = ad?.postedDateTime else {
            return "N/A"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"
        if let date = dateFormatter.date(from: dateTime) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy"
            return dateFormatter.string(from: date)
        }
        return "N/A"
    }
    
    var visits: String {
        return "\(ad?.visits ?? 0)"
    }
    
    var attributes: [(String, String)] {
        guard let attributes = ad?.attributes else { return [] }
        let arr = attributes.map { attribute in
            return (attribute.label ?? "", attribute.value ?? "")
        }
        return arr
    }
    
    var documents: [Document] {
        return ad?.documents ?? []
    }
    
    var features: [String] {
        return ad?.features ?? []
    }
    
    var description: String {
        return ad?.itemDescription ?? "N/A"
    }

    // MARK: - Private
    private var ad: Ad?
    private let fetcher: Fetcher
    private var disposables = Set<AnyCancellable>()

    @Published private(set) var state: State = .isLoading
    
    
    init(with id: String) {
        self.fetcher = Fetcher()
        
        state = .isLoading
        self.fetcher.fetchAd(withId: id)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] error in
                    guard let self = self else { return }
                    let err: NetworkError = .network(description: "Could not fetch ad data")
                    self.state = .failed(err)
                    switch error {
                    case .failure:
                        self.ad = nil
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] ad in
                    guard let self = self else { return }
                    self.state = .loaded(ad)
                    self.ad = ad
                })
            .store(in: &disposables)
    }
    
}

