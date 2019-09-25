//
//  ViewController.swift
//  CollectionViewAnimation
//
//  Created by Shuai Hao on 2019/9/24.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

extension Array {
    func safeIndex(_ i: Int) -> Element? {
        return i < self.count && i >= 0 ? self[i] : nil
    }
}

class ViewController: UIViewController {
    
    fileprivate struct Storyboard {
        static let CellIdentifier = "AnimationCollectionViewCell"
        static let NibName = "AnimationCollectionViewCell"
    }
    
    fileprivate struct Constants {
        static let AnimationDuration: Double = 0.5
        static let AnimationDelay: Double = 0.0
        static let AnimationSpringDamping: CGFloat = 1.0
        static let AnimationInitialSpringVelocity: CGFloat = 1.0
    }
    
    fileprivate var imageCollection: AnimationImageCollection!
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: self.view.bounds.size.width, height: 240)
        let collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: Storyboard.NibName, bundle: nil), forCellWithReuseIdentifier: Storyboard.CellIdentifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollection = AnimationImageCollection()
        view.addSubview(self.collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.collectionView.reloadData()
    }

    
    fileprivate func handleAnimationCellSelected(_ collectionView: UICollectionView, cell: AnimationCollectionViewCell) {
        cell.handleCellSelected()
        cell.backButtonTapped = self.backButtonDidTouch
        
        let animations = {
            let y: CGFloat = 24.0
            let height: CGFloat = collectionView.frame.size.height - y
            let frame = CGRect(x: 0.0, y: y, width: collectionView.frame.size.width, height: height)
            
            cell.frame = frame
        }
        
        let completion: (_ finish: Bool) -> () = { _ in
            collectionView.isScrollEnabled = false
        }
        
        UIView .animateKeyframes(withDuration: Constants.AnimationDuration, delay: Constants.AnimationDelay, options: [], animations: animations, completion: completion)
    }
    
    func backButtonDidTouch() {
        guard let indexPaths = self.collectionView.indexPathsForSelectedItems else {
            return
        }
        
        collectionView.isScrollEnabled = true
        collectionView.reloadItems(at: indexPaths)
    }

}

extension ViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as? AnimationCollectionViewCell,
            let viewModel = imageCollection.images.safeIndex(indexPath.item)  else {
            return UICollectionViewCell()
        }
        cell.prepareCell(viewModel)

        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AnimationCollectionViewCell else {
            return
        }
        
        self.handleAnimationCellSelected(collectionView, cell: cell)
    }
}


