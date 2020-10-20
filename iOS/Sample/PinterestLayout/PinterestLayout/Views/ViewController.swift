//
//  ViewController.swift
//  PinterestLayout
//
//  Created by Yeojaeng on 2020/10/18.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- Properties
    
    let viewModel: ViewModel = ViewModel(client: UnsplashClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            collectionView.collectionViewLayout = layout
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets(top: 10,
                                                   left: 10,
                                                   bottom: 10,
                                                   right: 10)
        
        // Init ViewModel
        
        // showLoading 클로저 호출시 실행
        viewModel.showLoading = {
            // 이미지 다운로드중인 경우
            if self.viewModel.isLoading {
                self.activityIndicator.startAnimating()
                self.collectionView.alpha = 0.0
            }
            
            // 이미지 다운로드가 끝난 경우
            else {
                self.activityIndicator.stopAnimating()
                self.collectionView.alpha = 1.0
            }
        }
        
        // showError 클로저가 호출시 실행
        viewModel.showError = { error in
            print(error)
        }
        
        // reloadData 클로저 호출시 실행
        viewModel.reloadData = {
            self.collectionView.reloadData()
        }
        
        // 이미지 다운로드 받아오기
        viewModel.fetchPhotos()
    }
}

// MARK:- DataSource Methods

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell",
                                                            for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        let image = viewModel.cellViewModels[indexPath.item].image
        cell.imageView.image = image
        return cell
    }
}

// MARK:- CustomFlowLayout Delegate
extension ViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = viewModel.cellViewModels[indexPath.item].image
        let height = image.size.height
        return height
    }
}
