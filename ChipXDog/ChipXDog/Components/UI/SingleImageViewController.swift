//
//  SingleImageViewController.swift
//  ChipXDog
//
//  Created by Joe on 03/06/2022.
//

import UIKit

class SingleImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    private var index: Int = 0
    private var imageURLS: [String]?
    private var images: [UIImage]?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getInstance(index: Int) -> SingleImageViewController {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: SingleImageViewController.self)) as! SingleImageViewController
        vc.index = index
        return vc
    }
}
