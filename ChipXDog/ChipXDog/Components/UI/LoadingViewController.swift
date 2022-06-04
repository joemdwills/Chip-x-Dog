//
//  LoadingViewController.swift
//  ChipXDog
//
//  Created by Joe on 04/06/2022.
//

import UIKit

class LoadingViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .medium)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0)
        
        spinner.color = UIColor(red: 0.0, green: 221/255, blue: 196/255, alpha: 100)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
