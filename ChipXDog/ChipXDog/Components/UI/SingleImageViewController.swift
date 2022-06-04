//
//  SingleImageViewController.swift
//  ChipXDog
//
//  Created by Joe on 03/06/2022.
//

import UIKit

class SingleImageViewController: UIViewController {
    var dogAPI = DogAPI()
    var dog = Breed(type: "akita")
    @IBOutlet weak var imageView: UIImageView!
    private var imageURLS: [String]?
    private var images: [UIImage]?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages()
    }
    
    func fetchImages() {
        dogAPI.dogService.fetchDogImages(breed: dog) { [self] result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(Images.self, from: data)
                    imageURLS = json.message
//                    loadImages {
//                        DispatchQueue.main.async {
//                            <#code#>
//                        }
//                    }
                    
                    
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
            DispatchQueue.global().async { [self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        images?.append(image)
                    }
                }
            }
            print(imageURL)
            count += 1
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
