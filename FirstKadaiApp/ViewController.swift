//
//  ViewController.swift
//  FirstKadaiApp
//
//  Created by AiTH2 on 2018/12/04.
//  Copyright © 2018 hirohisa.kimura. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var labelContainer: UIView!
    @IBOutlet weak var label: UILabel!
    
    let startColor = "0066ff"
    let endColor = "a0ffff"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black

    }
    
    override func viewDidLayoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.init(hex: startColor).cgColor , UIColor.init(hex: endColor).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = labelContainer.bounds
        
        labelContainer.layer.addSublayer(gradientLayer)
        
        labelContainer.mask = label
        
        let minX =  Int(labelContainer.frame.minX)
        let maxX =  Int(labelContainer.frame.maxX)
        let centerX =  (maxX + minX) / 2
        
        textMove()
        
        lineView(10, 2.1, [maxX + 30, centerX, maxX])
        lineView(15, 2.1, [maxX - 30, minX, maxX])
        lineView(20, 2.1, [centerX + 60, minX + 40, maxX])
        lineView(25, 2.1, [centerX - 50, centerX + 100, maxX])
        lineView(10, 2.1, [minX - 10, maxX + 30, maxX])
        
        appeareLogoX()
    
        whiteFeedView()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
//            self.lineView(10, 0.0, [maxX + 30, centerX, maxX])
//            self.lineView(15, 0.0, [maxX - 30, minX, maxX])
//            self.lineView(20, 0.0, [centerX + 60, minX + 40, maxX])
//            self.lineView(25, 0.0, [centerX - 50, centerX + 100, maxX])
//            self.lineView(10, 0.0, [minX - 10, maxX + 30, maxX])
//        }
//
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 11.6) {
//            self.appeareLogoX()
//        }
    }
    
    
    func textMove(){
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.duration = 0.3
        alphaAnimation.fromValue = 0.3
        alphaAnimation.toValue = 1.0
        alphaAnimation.repeatCount = 7
        label.layer.add(alphaAnimation, forKey: "alpha")
        
        
        let startPoint = CGPoint(
            x: labelContainer.center.x + 40,
            y: labelContainer.center.y - 30
        )
        let middlePoint = CGPoint(
            x: labelContainer.center.x + 30,
            y: labelContainer.center.y - 20
        )
        let endPoint = labelContainer.center

        
        let moveAnimation = CAKeyframeAnimation(keyPath: "position")
        moveAnimation.duration = 0.3
        moveAnimation.repeatCount = 7
        moveAnimation.values = [startPoint, middlePoint, endPoint]
        moveAnimation.keyTimes = [0, 0.5, 1]
        //moveAnimation.delegate = self
        
        labelContainer.layer.add(moveAnimation, forKey: "moveAnimation")
        
    }
    
//    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        print("flag::\(flag)")
//        if flag {
//            let minX =  Int(labelContainer.frame.minX)
//            let maxX =  Int(labelContainer.frame.maxX)
//            let centerX =  (maxX + minX) / 2
//
//            lineView(10, 0.0, [maxX + 30, centerX, maxX])
//            lineView(15, 0.0, [maxX - 30, minX, maxX])
//            lineView(20, 0.0, [centerX + 60, minX + 40, maxX])
//            lineView(25, 0.0, [centerX - 50, centerX + 100, maxX])
//            lineView(10, 0.0, [minX - 10, maxX + 30, maxX])
//
//            appeareLogoX()
//        }
//    }
    
    
    func lineView(_ lineWidth: Int, _ delay: Double, _ posX: [Int]){
        
        let view = UIView()
        view.frame = CGRect(x: posX[2], y: 0, width: lineWidth, height: 900)
        view.backgroundColor = UIColor.init(hex: "f2f200")
        view.alpha = 0.0
        
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.beginTime = CACurrentMediaTime() + delay
        alphaAnimation.duration = 0.1
        alphaAnimation.fromValue = 0.0
        alphaAnimation.toValue = 1.0
        alphaAnimation.isRemovedOnCompletion = false
        alphaAnimation.fillMode = .forwards
        view.layer.add(alphaAnimation, forKey: "alphaAnimation")
        
//        view.layer.shadowColor = UIColor.init(hex: "000000").cgColor
//        view.layer.shadowOpacity = 0.3
//        view.layer.shadowOffset = CGSize(width: 0, height: 0)
//        view.layer.shadowRadius = 1
        
        self.view.insertSubview(view, belowSubview: labelContainer)
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform")
        rotateAnimation.duration = 1.5
        rotateAnimation.repeatCount = Float.infinity
        let transform = CATransform3DMakeRotation(CGFloat(Double.pi),  0, 1.0, 0)
        rotateAnimation.toValue = NSValue(caTransform3D : transform)
        
        let zAnimation = CABasicAnimation(keyPath: "transform.translation.z")
        zAnimation.fromValue = -50
        zAnimation.toValue = -50
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = Double.random(in: 0.7 ..< 1.5)
        animationGroup.beginTime = CACurrentMediaTime() + delay
        animationGroup.repeatCount = Float.infinity
        animationGroup.animations = [rotateAnimation, zAnimation]
        
        view.layer.add(animationGroup, forKey: "Animation")
        
        
        let positionXKeyframe = CAKeyframeAnimation(keyPath: "position.x")
        positionXKeyframe.beginTime = CACurrentMediaTime() + delay
        positionXKeyframe.values = [posX[0], posX[1], posX[2]]
        let cvX = Double.random(in: 0.4 ..< 0.7) as NSNumber
        positionXKeyframe.keyTimes = [0, cvX, 1]
        positionXKeyframe.duration = 8.0
        
        view.layer.add(positionXKeyframe, forKey: "positionX")
        
        
        let positionYKeyframe = CAKeyframeAnimation(keyPath: "position.y")
        positionYKeyframe.beginTime = CACurrentMediaTime() + delay
        positionYKeyframe.values = [-450, 0, 450]
        positionYKeyframe.keyTimes = [0, 0.5, 1]
        positionYKeyframe.duration = 3.0
        
        view.layer.add(positionYKeyframe, forKey: "positionY")
        
        let colorAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
        colorAnimation.beginTime = CACurrentMediaTime() + delay
        colorAnimation.values = [
            UIColor.init(hex: "c0c0ff").cgColor,
            UIColor.init(hex: "c0c000").cgColor
        ]
        let cahngeValue = Double.random(in: 0.4 ..< 0.7) as NSNumber
        colorAnimation.keyTimes = [0.0, cahngeValue]
        colorAnimation.duration = 7.0
        
        view.layer.add(colorAnimation, forKey: "bgColor")
        
        
        let boundsSizeHeight = CAKeyframeAnimation(keyPath: "bounds.size.height")
        boundsSizeHeight.beginTime = CACurrentMediaTime() + delay + 9.0
        boundsSizeHeight.values = [900, 450, 0]
        boundsSizeHeight.keyTimes = [0, 0.5, 1]
        boundsSizeHeight.duration = 0.5
        boundsSizeHeight.isRemovedOnCompletion = false
        boundsSizeHeight.fillMode = .forwards
        
        view.layer.add(boundsSizeHeight, forKey: "boundsSizeHeight")
        
    }
    
    func appeareLogoX(){
        let imageView = UIImageView()
        imageView.frame = CGRect(
            x: labelContainer.frame.maxX + 10,
            y: labelContainer.frame.maxY - 20,
            width: 0,
            height: 0
        )
        
        imageView.image = UIImage(named:"image_x.png")
        imageView.contentMode = .scaleAspectFit
        
        self.view.insertSubview(imageView, at: 1)
        
        UIView.animate(
            withDuration: 0.2,
            delay: 11.6,
            options: [.curveEaseIn],
            animations: {
                imageView.bounds.size = CGSize(width: self.labelContainer.bounds.height*3, height: self.labelContainer.bounds.height*3)
            },
            completion: nil
        )
    }
    
    func whiteFeedView(){
        let whiteView = UIView(frame: self.view.frame)
        whiteView.backgroundColor = UIColor.white
        whiteView.alpha = 0.0
        self.view.addSubview(whiteView)
        self.view.bringSubviewToFront(whiteView)
        
        UIView.animate(
            withDuration: 0.2,
            delay: 12.0,
            options: [.curveLinear],
            animations: {
                whiteView.alpha = 1.0
            },
            completion: {_ in
                UIView.animate(
                    withDuration: 0.2,
                    animations: {
                        whiteView.alpha = 0.0
                    }
                )
                
            }
        )

    }

}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let v = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
}
