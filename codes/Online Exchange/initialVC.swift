//
//  initialVC.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 5/15/24.
//

import UIKit
import Lottie

class initialVC: UIViewController {

    @IBOutlet weak var lottie: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = LottieAnimationView(name: "Welcome")
                animationView.center = self.view.center
                animationView.contentMode = .scaleAspectFit
                animationView.frame = CGRect(x: 10, y: 120, width: 400, height: 500)
                view.addSubview(animationView)
                animationView.play()
                animationView.loopMode = .loop

        // Do any additional setup after loading the view.
    }

}
