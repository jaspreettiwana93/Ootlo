//
//  JOpenImage.swift
//  Tournament App
//
//  Created by Mac on 12/08/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class JOpenImage: UIViewController, UIScrollViewDelegate {

    var imageURL = ""
    var image = UIImage()
    
    var scrollViewMain = UIScrollView()
    var viewInnerScroll = UIView()
    var imageMain = UIImageView()
    
    var crossButton = UIButton()
    
    var isViewInit = false
    
    var oldFrame = CGRect()
    var frame = CGRect()
    
    var viewBlue = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidLayoutSubviews() {
        if(!isViewInit)
        {
            isViewInit = true
            
            viewBlue.frame = view.bounds
            viewBlue.backgroundColor = .black
            viewBlue.alpha = 0.8
            view.addSubview(viewBlue)
            
            scrollViewMain.frame = view.frame
            scrollViewMain.delegate = self
            scrollViewMain.maximumZoomScale = 4.0
            scrollViewMain.backgroundColor = .clear
            view.addSubview(scrollViewMain)
            
            viewInnerScroll.frame = view.frame
            viewInnerScroll.backgroundColor = .clear
            scrollViewMain.addSubview(viewInnerScroll)
            
            imageMain.frame = viewInnerScroll.frame
            viewInnerScroll.addSubview(imageMain)
            
            imageMain.contentMode = .scaleAspectFit
            
            if(imageURL == "")
            {
                imageMain.image = image
            }
            else
            {
                setFullImageWith(imageView: imageMain, url: imageURL) {
                    
                }
            }
            
//            imageMain.setImage(url: imageURL) {
////                let containerView = UIView(frame: self.imageMain.frame)
//////                let imageView = UIImageView()
////
////                if let image = self.imageMain.image {
////                    let ratio = image.size.width / image.size.height
////                    if image.size.width > image.size.height {
////                        let newHeight = containerView.frame.width / ratio
////                        self.imageMain.frame.size = CGSize(width: containerView.frame.width, height: newHeight)
////                        self.imageMain.frame = CGRect(x: 0,
////                                                            y: (self.viewInnerScroll.frame.size.height / 2) - (self.imageMain.frame.size.height / 2),
////                                                            width: self.viewInnerScroll.frame.size.width,
////                                                            height: self.imageMain.frame.size.height)
////                    }
////                    else{
////                        let newWidth = containerView.frame.height * ratio
////                        self.imageMain.frame.size = CGSize(width: newWidth, height: containerView.frame.height)
////                        self.imageMain.frame = CGRect(x: (self.viewInnerScroll.frame.size.width / 2) - (self.imageMain.frame.size.width / 2),
////                                                            y: 0,
////                                                            width: self.imageMain.frame.size.width,
////                                                            height: self.viewInnerScroll.frame.size.height)
////                    }
////                }
//
//
//            }
            
            crossButton.frame = CGRect(x: 5, y: 22, width: 48, height: 48)
//            crossButton.setTitle("x", for: .normal)
            let origImage = UIImage(named: "cross-icon")!
            let tintedImage = origImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            crossButton.setImage(tintedImage, for: .normal)
            crossButton.tintColor = .white
            crossButton.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7)
//            crossButton.setTitleColor(.white, for: .normal)
//            crossButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
            crossButton.addTarget(self, action: #selector(closeAction(sender:)), for: .touchUpInside)
            view.addSubview(crossButton)
            
            showAnimation()
        }
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageMain
    }
    
    @objc func closeAction(sender: UIButton)
    {
        hideAnimation()
    }
    
    func showAnimation()
    {
//        frame = self.scrollViewMain.frame
        self.scrollViewMain.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
//        self.scrollViewMain.frame = oldFrame
        UIView.animate(withDuration: 0.2,
                       animations: {
                        self.scrollViewMain.transform = CGAffineTransform.identity
//                        self.scrollViewMain.frame = self.frame
        },
                       completion: { _ in
//                        UIView.animate(withDuration: 0.6) {
//                            self.scrollViewMain.transform = CGAffineTransform.identity
//                        }
        })
    }
    
    func hideAnimation()
    {
        self.scrollViewMain.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.2,
                       animations: {
                        self.scrollViewMain.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//                        self.scrollViewMain.frame = self.oldFrame
                    },
                       completion: { _ in
                            self.dismiss(animated: false, completion: nil)
                    })
    }

    func setFullImageWith(imageView: UIImageView, url: String, completion: @escaping () -> ())
    {
        if(url != "")
        {
            imageView.sd_setIndicatorStyle(.white)
            imageView.sd_setShowActivityIndicatorView(true)
            let url2 = url.replacingOccurrences(of: " ", with: "%20")
            imageView.sd_setImage(with: URL(string: url2), completed: { (image, error, cache, url3) in
                imageView.sd_setShowActivityIndicatorView(false)
                if(image == nil && error != nil)
                {
                    //                    self.setImage(url: url, completion: {
                    //
                    //                    })
                    imageView.image = UIImage(named: "placeholder-organization")!
                }
                completion()
            })
        }
        else
        {
            imageView.image = UIImage(named: "placeholder-organization")!
        }
        
    }
    
}
