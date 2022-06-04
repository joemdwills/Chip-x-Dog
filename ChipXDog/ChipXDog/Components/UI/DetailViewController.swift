//
//  DetailViewController.swift
//  ChipXDog
//
//  Created by Joe on 02/06/2022.
//

import UIKit

final class DetailViewController: UICollectionViewController {
    let loadingView = LoadingViewController()
    var dogAPI = DogAPI()
    var dog: Breed?
    private var imageURLS: [String]?
    private var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let dog = dog else {
            return
        }
        if let subBreed = dog.subBreed {
            title = "\(subBreed) \(dog.type)"
        } else {
            title = "\(dog.type)"
        }
        title = title?.capitalized
        
        addChild(loadingView)
        loadingView.view.frame = view.frame
        view.addSubview(loadingView.view)
        loadingView.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        createSpinnerView()
        fetchImages()
    }
    
    func fetchImages() {
        guard let dog = dog else {
            return
        }
        dogAPI.dogService.fetchDogImages(breed: dog) { [self] result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(Images.self, from: data)
                    imageURLS = json.message
                    loadImages { [self] in
                        DispatchQueue.main.async { [self] in
                            collectionView.reloadData()
                            loadingView.willMove(toParent: nil)
                            loadingView.view.removeFromSuperview()
                            loadingView.removeFromParent()
                        }
                        print("----> Images Array Count: \(String(describing: images.count))")
                    }
                } catch {
                    print("Error Decoding")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadImages(completion: @escaping () -> Void) {
        var count = 0
        while count < 10 {
            guard let imageURL = imageURLS?.randomElement() else { return }
            guard let url = URL(string: imageURL) else { return }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    images.append(image)
                }
            }
//            print(imageURL)
            count += 1
        }
        completion()
    }
    
//    func createSpinnerView() {
//        let child = LoadingViewController()
//
//        // add the spinner view controller
//
//
//        // wait two seconds to simulate some work happening
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            // then remove the spinner view controller
//
//        }
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? DogImageCell else {
            fatalError("Unable to dequeue DogImageCell")
        }
        cell.imageView.image = images[indexPath.item]
        cell.imageView.contentMode = .scaleAspectFill
        cell.imageView.layer.cornerRadius = 25
        return cell
    }
}
