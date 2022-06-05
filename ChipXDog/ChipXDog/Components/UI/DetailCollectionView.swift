//
//  DetailViewController.swift
//  ChipXDog
//
//  Created by Joe on 02/06/2022.
//

import UIKit

final class DetailCollectionView: UICollectionViewController {
    var viewModel: DetailCollectionViewModel!
    let loadingView = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title.capitalized
        
        addChild(loadingView)
        loadingView.view.frame = view.frame
        view.addSubview(loadingView.view)
        loadingView.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchImageURLS {
            DispatchQueue.main.async { [self] in
                loadingView.willMove(toParent: nil)
                loadingView.view.removeFromSuperview()
                loadingView.removeFromParent()
                collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? DogImageCell else {
            fatalError("Unable to dequeue DogImageCell")
        }
        cell.imageView.image = viewModel.images[indexPath.item]
        cell.imageView.contentMode = .scaleAspectFill
        cell.imageView.layer.cornerRadius = 25
        return cell
    }
}
