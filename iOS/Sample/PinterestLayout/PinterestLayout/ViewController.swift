//
//  ViewController.swift
//  PinterestLayout
//
//  Created by Yeojaeng on 2020/10/18.
//

import UIKit

class ViewController: UIViewController {

    // MARK:- Outlet

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK:- Properties

    let images: [UIImage] = [#imageLiteral(resourceName: "test2"), #imageLiteral(resourceName: "test1"), #imageLiteral(resourceName: "test4"), #imageLiteral(resourceName: "test3"), #imageLiteral(resourceName: "test5")]

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets(top: 10,
                                                   left: 10,
                                                   bottom: 10,
                                                   right: 10)
    }

}

// MARK:- DataSource Methods

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        cell.imageView.image = images[indexPath.item]
        cell.imageView.clipsToBounds = true
        return cell
    }
}

// MARK:- Flow Layout Delegatev

extension ViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {

        let image = images[indexPath.row]
        let height = image.size.height
        
        return height
    }
}
