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
  
  let iconsContainerView: UIView = {
    let containerView = UIView()
    containerView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
    containerView.backgroundColor = .red
    return containerView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    addBackgroundImageView()
    addIconsContainerView()
    setupLongPressGesture()
  }

  private func addBackgroundImageView() {
    backgroundImageView.frame = view.frame
    view.addSubview(backgroundImageView)
  }
  
  private func addIconsContainerView() {
    
  }
  
  private func setupLongPressGesture() {
    let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
    view.addGestureRecognizer(gestureRecognizer)
  }
  
  @objc func handleLongPressGesture(gestureRecognizer: UILongPressGestureRecognizer) {
    switch gestureRecognizer.state {
    case .began:
      handleGestureBegan(gestureRecognizer: gestureRecognizer)
    case .ended:
      iconsContainerView.removeFromSuperview()
    case .cancelled, .changed, .failed, .possible:
      break
    @unknown default:
      fatalError()
    }
  }
  
  private func handleGestureBegan(gestureRecognizer: UILongPressGestureRecognizer) {
    view.addSubview(iconsContainerView)
    
    let pressedLocation = gestureRecognizer.location(in: view)
    let centeredX = (view.frame.width - iconsContainerView.frame.width) / 2
    
    iconsContainerView.alpha = 0
    iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y)
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      
      self.iconsContainerView.alpha = 1
      self.iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y - self.iconsContainerView.frame.height)
    })
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}

