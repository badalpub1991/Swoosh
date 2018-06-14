# Swoosh

//
//  DataServices.swift
//  Comapi
//
//  Created by badal shah on 26/04/18.
//  Copyright © 2018 badal shah. All rights reserved.
//

     import Foundation
     import UIKit
     class DataServices {
        static let instance = DataServices()
    
      var repos = [Repos]() //Array of Channel Object
      var commits = [Commits]()
      var releases = [Releases]()
      var image=UIImage()

    
    //Get repos

    func makeGetCall(complition: @escaping ComplitionHandler) {
        // Set up the URL request
       
        guard let url = URL(string: URL_REPOS) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
           
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                complition(false)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                 complition(false)
                return
            }

            
            // parse the result as JSON, since that's what the API provides
            do {

                 self.repos = try JSONDecoder().decode([Repos].self, from: responseData)
                complition(true)

            } catch  {
                 debugPrint(error as Any)
                return
            }
        }
        task.resume()
    }
    
    func getComits (url:String,actionType:ActionType , complition: @escaping ComplitionHandler) {
        
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                complition(false)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                complition(false)
                return
            }
            
            
            // parse the result as JSON, since that's what the API provides
            do {
                if actionType == .commits {
                    self.commits = try JSONDecoder().decode([Commits].self, from: responseData) } else
                {
                    self.releases = try JSONDecoder().decode([Releases].self, from: responseData)
                }
                complition(true)
                
            } catch  {
                debugPrint(error as Any)
                return
            }
        }
        task.resume()
        
    }
    
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
           // let image = UIImage(data: data!)
            //self.image = image!
            }.resume()
    }
    
    func alert(message: String, title: String, viewcontroller:UIViewController, completion: @escaping ComplitionHandler) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (success) in
            completion(true)
        }
       
        alertController.addAction(OKAction)
       viewcontroller.present(alertController, animated: true, completion: nil)
    }
    

        
    }
    
Commit Model


     import Foundation

    struct Commits: Decodable {    //All key in Same Order and As Same name for Encode and Decode Json as Swift4
    
    public private(set)  var sha : String?
    public private(set) var commit : Commit?
    public private(set)  var url : String?
    public private(set)  var html_url : String?
    public private(set)  var comments_url : String?
    public private(set) var author : Author?
    public private(set)  var committer : Committer?
    
    
  

   
    }

    struct Commit : Decodable {

    public private(set) var author : Author?
    public private(set) var committer : Committer?
    public private(set) var comment_count : Double?
    

    }

    struct Author : Decodable {
    let name : String?
    let date : String?
    let login : String?
    let id : Int?
    let avatar_url : String!
    let gravatar_id : String?
    let url : String?
    let html_url : String?
    let followers_url : String?
    let following_url : String?
    let gists_url : String?
    let starred_url : String?
    let subscriptions_url : String?
    let organizations_url : String?
    let repos_url : String?
    let events_url : String?
    let received_events_url : String?
    let type : String?
    let site_admin : Bool?

    }

    struct Committer : Decodable {
    let login : String?
    let id : Int?
    let avatar_url : String?
    let gravatar_id : String?
    let url : String?
    let html_url : String?
    let followers_url : String?
    let following_url : String?
    let gists_url : String?
    let starred_url : String?
    let subscriptions_url : String?
    let organizations_url : String?
    let repos_url : String?
    let events_url : String?
    let received_events_url : String?
    let type : String?
    let site_admin : Bool?
    }
    
 Image Load
 
      func configureCell(commits:Commits) {
        self.lblName.text = commits.commit?.author?.name
        self.lblDate.text = commits.commit?.author?.date
        
        if commits.committer?.avatar_url == nil {
            self.avtarImageView.image = #imageLiteral(resourceName: "no_image")
        } else {
        DataServices.instance.getDataFromUrl(url: NSURL(string: (commits.committer?.avatar_url)!)! as URL) { (data, response, error) in
            DispatchQueue.main.async {
                self.avtarImageView.image = UIImage(data: data!)
            }
        }
        }
        if commits.commit?.comment_count == 0 {
            self.lblComment.text = "No comment found for this repo"
        }

    }
    

