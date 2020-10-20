//
//  ViewModel.swift
//  PinterestLayout
//
//  Created by Yeojaeng on 2020/10/18.
//

import Foundation
import UIKit

struct CellViewModel {
    let image: UIImage
}

class ViewModel {
    
    // MARK:- Properties
    private let client: APIClient // access to APIClient
    var cellViewModels: [CellViewModel] = []
    var reloadData: (() -> Void)?
    var showLoading: (() -> Void)?
    var showError: ((Error) -> Void)?
    private var photos: Photos = [] { // photos 값이 변경될 때 마다 호출, 비동기 다운로드
        didSet {
            self.fetchPhoto()
        }
    }
    
    // MARK:- UI
    var isLoading: Bool = false {
        didSet {
            showLoading?() // isLoading 프로퍼티 값이 변화하면 showLoading 클로저 호출
        }
    }
    
    init(client: APIClient) {
        self.client = client
    }
    
    // MARK:- Methods
    func fetchPhotos() {
        if let client = client as? UnsplashClient {
            self.isLoading = true // isLoading 값이 변하면서 showLoading 클로저 호출
            
            // https://api.unsplash.com/photos?client_id=UnsplashClient.apiKey&orderBy=popular
            let endPoint = UnsplashEndPoint.photos(client_id: UnsplashClient.apiKey,
                                                   orderBy: .polular)
            client.fetch(with: endPoint) { result in
                switch result {
                case .success(let photos):
                    self.photos = photos        // 다운로드 받은 이미지를 photos에 저장
                case .failure(let error):
                    self.showError?(error)
                }
            }
        }
    }
    
    private func fetchPhoto() {
        let group = DispatchGroup()
        
        // on Main Thread
        self.photos.forEach { [weak self] (photo) in
            guard let self = self else { return }
            DispatchQueue.global(qos: .background).async(group: group) {
                group.enter()
                // URL -> Data
                guard let imageData = try? Data(contentsOf: photo.urls.thumb) else {
                    self.showError?(APIError.imageDownload)
                    return
                }
                
                // Data -> UIImage
                guard let image = UIImage(data: imageData) else {
                    self.showError?(APIError.imageConvert)
                    return
                }
                
                // ViewModel 추가
                self.cellViewModels.append(CellViewModel(image: image))
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
            self.reloadData?()      // 클로저를 호출하여 reload 시점을 일러준다.
        }
    }
}
