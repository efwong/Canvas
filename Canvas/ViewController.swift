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

}

