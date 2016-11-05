//
//  ViewController.swift
//  Canvas
//
//  Created by Edwin Wong on 11/4/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalPos: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayCenterWhenOpen = CGPoint(x: trayView.center.x, y: 806-170)
        trayCenterWhenClosed = CGPoint(x: trayView.center.x, y: 806)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let point = panGestureRecognizer.location(in: trayView)
        //let translation = panGestureRecognizer.translation(in: trayView)
        let velocity = panGestureRecognizer.velocity(in: trayView)
        if panGestureRecognizer.state == .began {
            trayOriginalCenter = trayView.center
        } else if panGestureRecognizer.state == .changed {
            if velocity.y > 0{
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                    self.trayView.center.y = self.trayCenterWhenClosed.y
                }, completion: nil)
            }else if velocity.y < 0{
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                    self.trayView.center.y = self.trayCenterWhenOpen.y
                    }, completion: nil)
            }
            //trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if panGestureRecognizer.state == .ended {
            print("Gesture ended at: \(point)")
        }
    }
    
    
    
    @IBAction func onSmileyDrag(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let imageView = panGestureRecognizer.view as! UIImageView
        let translation = panGestureRecognizer.translation(in: self.view)
        
        if panGestureRecognizer.state == .began {
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            // Add the new face to the tray's parent view.
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            //let point = panGestureRecognizer.location(in: trayView)
            newlyCreatedFaceOriginalPos = newlyCreatedFace.center
        } else if panGestureRecognizer.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalPos.x + translation.x, y: newlyCreatedFaceOriginalPos.y + translation.y)
        } else if panGestureRecognizer.state == .ended {
            //print("Gesture ended at: \(point)")
        }
    }

}

