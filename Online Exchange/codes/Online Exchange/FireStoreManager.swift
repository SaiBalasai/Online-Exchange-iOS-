
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import Firebase
import FirebaseFirestoreSwift

struct Photo {
    var image: UIImage
    var downloadURL: URL?
}

class FireStoreManager {
    
    public static let shared = FireStoreManager()
    var hospital = [String]()
    
    var db: Firestore!
    var dbRef : CollectionReference!
    
    init() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        dbRef = db.collection("Users")
    }
    
    func signUp(user: UserRegistrationModel, completion: @escaping (Bool)->()) {
        getQueryFromFirestore(field: "email", compareValue: user.email ?? "") { querySnapshot in
            print(querySnapshot.count)
            
            if querySnapshot.count > 0 {
                globalAlart(message: "This Email is Already Registered!!")
                completion(false)
            } else {
                let data = [
                    "firstname": user.firstname ?? "",
                    "lastname": user.lastname ?? "",
                    "email": user.email ?? "",
                    "phone": user.phone ?? "",
                    "password": user.password ?? ""
                ]
                
                self.addDataToFireStore(data: data) { _ in
                    showOkAlertAnyWhereWithCallBack(message: "Registration Success!!") {
                        
                        DispatchQueue.main.async {
                            completion(true)
                        }
                        
                    }
                    
                }
            }
        }
    }
    
    
    
    func login(email:String,password:String,completion: @escaping (Bool)->()) {
        let  query = db.collection("Users").whereField("email", isEqualTo: email)
        
        query.getDocuments { (querySnapshot, err) in
            
            print(querySnapshot?.count)
            
            if(querySnapshot?.count == 0) {
                globalAlart(message: "Email id not found!!")
            }else {
                
                for document in querySnapshot!.documents {
                    print("doclogin = \(document.documentID)")
                    UserDefaults.standard.setValue("\(document.documentID)", forKey: "documentId")
                    
                    if let pwd = document.data()["password"] as? String{
                        
                        if(pwd == password) {
                            
                            let name = document.data()["name"] as? String ?? ""
                            let email = document.data()["email"] as? String ?? ""
                            let phone = document.data()["phone"] as? String ?? ""
                            
                            UserDefaultsManager.shared.saveData(name: name, email: email, phone: phone)
                            completion(true)
                            
                        }else {
                            globalAlart(message: "Password doesn't match")
                        }
                        
                        
                    }else {
                        globalAlart(message: "Something went wrong!!")
                    }
                }
            }
        }
    }
    
    func getPassword(email:String,password:String,completion: @escaping (String)->()) {
        let  query = db.collection("Users").whereField("email", isEqualTo: email)
        
        query.getDocuments { (querySnapshot, err) in
            
            if(querySnapshot?.count == 0) {
                globalAlart(message: "Email id not found!!")
            }else {
                
                for document in querySnapshot!.documents {
                    print("doclogin = \(document.documentID)")
                    UserDefaults.standard.setValue("\(document.documentID)", forKey: "documentId")
                    if let pwd = document.data()["password"] as? String{
                        completion(pwd)
                    }else {
                        globalAlart(message: "Something went wrong!!")
                    }
                }
            }
        }
    }
    
    func getQueryFromFirestore(field:String,compareValue:String,completionHandler:@escaping (QuerySnapshot) -> Void){
        
        dbRef.whereField(field, isEqualTo: compareValue).getDocuments { querySnapshot, err in
            
            if let err = err {
                
                globalAlart(message: "Error getting documents: \(err)")
                return
            }else {
                
                if let querySnapshot = querySnapshot {
                    return completionHandler(querySnapshot)
                }else {
                    globalAlart(message: "Something went wrong!!")
                }
                
            }
        }
        
    }
    
    func addDataToFireStore(data:[String:Any] ,completionHandler:@escaping (Any) -> Void){
        let dbr = db.collection("Users")
        dbr.addDocument(data: data) { err in
            if let err = err {
                globalAlart(message: "Error adding document: \(err)")
            } else {
                completionHandler("success")
            }
        }
        
        
    }
    
    func updatePassword(documentid:String, userData: [String:String] ,completion: @escaping (Bool)->()) {
        let  query = db.collection("Users").document(documentid)
        
        query.updateData(userData) { error in
            if let error = error {
                print("Error updating Firestore data: \(error.localizedDescription)")
                // Handle the error
            } else {
                print("Profile data updated successfully")
                completion(true)
                // Handle the success
            }
        }
    }
    
}
