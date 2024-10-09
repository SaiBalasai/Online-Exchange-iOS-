//
//  initialVC.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 10/7/24.
//

import UIKit
import Lottie

class initialVC: UIViewController {
    
    
    
    
    @IBOutlet weak var lottie: LottieAnimationView!
    
    @IBAction func getStarted(_ sender: UIButton) {
        
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
    @IBOutlet weak var start: UIButton!
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
