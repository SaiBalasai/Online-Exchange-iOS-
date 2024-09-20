
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import Firebase


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
    
    func signUp(email:String, signupData: SignupModel) {
        
        self.checkAlreadyExistAndSignup(email: email, signupData: signupData)
    }
    
    func login(email:String,password:String,completion: @escaping (Bool)->()) {
        let  query = db.collection("Users").whereField("email", isEqualTo: email)
        
        query.getDocuments { (querySnapshot, err) in
                        
            if(querySnapshot?.count == 0) {
                showAlerOnTop(message: "Email id not found!!")
            }else {
                
                for document in querySnapshot!.documents {
                    print("doclogin = \(document.documentID)")
                    UserDefaults.standard.setValue("\(document.documentID)", forKey: "documentId")
                    
                    if let pwd = document.data()["password"] as? String{
                        
                        if(pwd == password) {
                            
                
                            let email = document.data()["email"] as? String ?? ""
                            let userType = document.data()["userType"] as? String ?? ""
                            let fullname = document.data()["fullname"] as? String ?? ""

                            UserDefaultsManager.shared.saveData(email: email, userType: userType, fullname: fullname)
                            completion(true)
                            
                        }else {
                            showAlerOnTop(message: "Password doesn't match")
                        }
                        
                        
                    }else {
                        showAlerOnTop(message: "Something went wrong!!")
                    }
                }
            }
        }
    }
    
    func checkAlreadyExistAndSignup(email:String, signupData: SignupModel) {
        
        getQueryFromFirestore(field: "email", compareValue: email) { querySnapshot in
            
            print(querySnapshot.count)
            
            if(querySnapshot.count > 0) {
                showAlerOnTop(message: "This Email is Already Registerd!!")
            }else {
                                
                let data = signupData.toDictionary()
                
                self.addDataToFireStore(data: data) { _ in
                    
                    showOkAlertAnyWhereWithCallBack(message: "Registration Success!!") {
                        
                        DispatchQueue.main.async {
                            SceneDelegate.shared?.openHomeOrLogin()
                        }
                        
                    }
                    
                }
                
            }
        }
    }
    
    func getQueryFromFirestore(field:String,compareValue:String,completionHandler:@escaping (QuerySnapshot) -> Void){
        
        dbRef.whereField(field, isEqualTo: compareValue).getDocuments { querySnapshot, err in
            
            if let err = err {
                
                showAlerOnTop(message: "Error getting documents: \(err)")
                return
            }else {
                
                if let querySnapshot = querySnapshot {
                    return completionHandler(querySnapshot)
                }else {
                    showAlerOnTop(message: "Something went wrong!!")
                }
                
            }
        }
        
    }
    
    func addDataToFireStore(data: [String: Any], completionHandler: @escaping (Any) -> Void) {
        let dbr = db.collection("Users")
        dbr.addDocument(data: data) { err in
                   if let err = err {
                       showAlerOnTop(message: "Error adding document: \(err)")
                   } else {
                       completionHandler("success")
                   }
     }
    }
    
    func getPassword(email:String,password:String,completion: @escaping (String)->()) {
        let  query = db.collection("Users").whereField("email", isEqualTo: email)
        
        query.getDocuments { (querySnapshot, err) in
            
            if(querySnapshot?.count == 0) {
                showAlerOnTop(message: "Email id not found!!")
            }else {
                
                for document in querySnapshot!.documents {
                    print("doclogin = \(document.documentID)")
                    UserDefaults.standard.setValue("\(document.documentID)", forKey: "documentId")
                    if let pwd = document.data()["password"] as? String{
                        completion(pwd)
                    }else {
                        showAlerOnTop(message: "Something went wrong!!")
                    }
                }
            }
        }
    }
    
    func addProductDetail(documentID: String, product: ProductModel, completionHandler: @escaping (Bool) -> ()) {
        
        let ref = dbRef.document(documentID)
        let productData = product.toDictionary()
        
        ref.getDocument { document, error in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                completionHandler(false)
                return
            }
            
            if let document = document, document.exists {
                let userref = self.dbRef.document(documentID).collection("Products").document()

                userref.setData(productData) { error in
                    if let error = error {
                        print("Error adding product to array: \(error.localizedDescription)")
                        completionHandler(false)
                    } else {
                        completionHandler(true)
                    }
                }
            } 
        }
    }

    func productRequestToAdmin(documentID: String, adminId: String, product: ProductModel, completionHandler: @escaping (Bool) -> ()) {
        let ref = dbRef.document(documentID)
        let productData = product.toDictionary()
        
        ref.collection("RequestBid")
            .whereField("productname", isEqualTo: product.productname)
                .whereField("price", isEqualTo: product.price)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching RequestBid documents: \(error.localizedDescription)")
                    completionHandler(false)
                    return
                }
                
                if let querySnapshot = querySnapshot, !querySnapshot.isEmpty {
                    print("Product already exists in RequestBid. Not adding again.")
                    completionHandler(false)
                    return
                }
                
                let userref = self.dbRef.document(documentID).collection("RequestBid").document()
                userref.setData(productData) { error in
                    if let error = error {
                        print("Error adding product to RequestBid: \(error.localizedDescription)")
                        completionHandler(false)
                    } else {
                        let adminRef = self.dbRef.document(adminId).collection("RequestBidFromUser").document()
                        adminRef.setData(productData) { error in
                            if let error = error {
                                print("Error adding product to RequestBidFromUser: \(error.localizedDescription)")
                                completionHandler(false)
                            } else {
                                completionHandler(true) // Successfully added the product
                            }
                        }
                    }
                }
            }
    }

    
    func getAdminProducts(completionHandler: @escaping ([ProductModel]?, Error?) -> ()) {
        var productsArray: [ProductModel] = []
        
        dbRef.whereField("userType", isEqualTo: "Admin")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching admin users: \(error.localizedDescription)")
                    completionHandler(nil, error)
                    return
                }
                
                guard let snapshot = snapshot else {
                    completionHandler(nil, nil)
                    return
                }
                
                let group = DispatchGroup()

                for document in snapshot.documents {
                    group.enter()
                    
                    let productsRef = self.dbRef.document(document.documentID).collection("Products")
                    
                    productsRef.getDocuments { (productSnapshot, error) in
                        if let error = error {
                            print("Error fetching products: \(error.localizedDescription)")
                            group.leave()
                            return
                        }
                        
                        if let productSnapshot = productSnapshot {
                            for productDocument in productSnapshot.documents {
                                let productData = productDocument.data()
                                if let product = ProductModel(dictionary: productData) {
                                    productsArray.append(product)
                                }
                            }
                        }
                        
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    completionHandler(productsArray, nil)
                }
            }
    }

    func getBidRequests(forUserId userId: String, completionHandler: @escaping ([ProductModel]?, Error?) -> ()) {
        let userRef = self.dbRef.document(userId).collection("RequestBidFromUser")

        userRef.getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching bid requests: \(error.localizedDescription)")
                completionHandler(nil, error)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No product requests found")
                completionHandler([], nil)
                return
            }

            let productRequests = documents.compactMap { document -> ProductModel? in
                let data = document.data()
                return ProductModel(dictionary: data)
            }

            completionHandler(productRequests, nil)
        }
    }



}

