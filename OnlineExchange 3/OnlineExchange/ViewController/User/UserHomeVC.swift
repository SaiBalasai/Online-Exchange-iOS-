
enum UserType : String {
    case admin = "Admin"
    case user = "User"
}


import UIKit
class UserHomeVC: UIViewController {
    
    
    
    @IBAction func Favorite(_ sender: UIButton) {
        
        performSegue(withIdentifier: "FavoriteCell", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let favouriteTVC = storyboard?.instantiateViewController(withIdentifier: "FavoriteCell") as! FavouriteTVC
        //        navigationController?.pushViewController(favouriteTVC, animated: true)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavoriteCell" {
            let favouriteTVC = segue.destination as! FavouriteTVC
            // Pass any necessary data to the FavouriteTVC here
        }
        
    }
}
