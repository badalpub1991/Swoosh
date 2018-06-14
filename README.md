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
