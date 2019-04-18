//
//  ViewController.swift
//  FacebookAnimation
//
//  Created by Nikita Teslyuk on 18/04/2019.
//  Copyright © 2019 Tesnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let backgroundImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "fb_core_data_bg.jpg"))
    return imageView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    addBackgroundImageView()
  }

  private func addBackgroundImageView() {
    backgroundImageView.frame = view.frame
    view.addSubview(backgroundImageView)
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}

