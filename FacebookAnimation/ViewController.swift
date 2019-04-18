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
    containerView.backgroundColor = .white
    
    let padding: CGFloat = 6
    let iconHeight: CGFloat = 38
    
    let iconImages = [
      UIImage(named: "blue_like"),
      UIImage(named: "red_heart"),
      UIImage(named: "surprised"),
      UIImage(named: "cry_laugh"),
      UIImage(named: "cry"),
      UIImage(named: "angry"),
    ]
    
    let arrangedSubviews = iconImages.map({ image -> UIView in
      let imageView = UIImageView(image: image)
      imageView.layer.cornerRadius = iconHeight / 2
      return imageView
    })
    
    let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
    stackView.distribution = .fillEqually
    
    //configurations
    let numberOfIcons: CGFloat = CGFloat(arrangedSubviews.count)
    let containerViewHeight = iconHeight + 2 * padding
    let containerViewWidth = numberOfIcons * iconHeight + (numberOfIcons + 1) * padding
    
    stackView.spacing = padding
    stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    stackView.isLayoutMarginsRelativeArrangement = true
    
    containerView.addSubview(stackView)
    
    containerView.frame = CGRect(x: 0, y: 0, width: containerViewWidth, height: containerViewHeight)
    
    //layer
    containerView.layer.cornerRadius = containerViewHeight / 2
    containerView.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
    containerView.layer.shadowRadius = 8
    containerView.layer.shadowOpacity = 0.5
    containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
    
    stackView.frame = containerView.frame
    return containerView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    addBackgroundImageView()
    setupLongPressGesture()
  }

  private func addBackgroundImageView() {
    backgroundImageView.frame = view.frame
    view.addSubview(backgroundImageView)
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

