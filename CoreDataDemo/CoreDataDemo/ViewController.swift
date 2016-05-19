//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Flare on 2016-05-15.
//  Copyright © 2016 Flare. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet var webview: UIWebView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadHTML()
        
        
    }
    
    func loadHTML(){
        var url = NSURL(string: "https://www.ecowebhosting.co.uk/")
        
        var request = NSURLRequest(URL: url!)
        
        webview.loadRequest(request)
    }
    
    func getJson(){
        let url = NSURL(string: "https://freegeoip.net/json/")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) ->Void in
            
            
            
            if let urlContent = data{
                
                do{
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    //optional. if it's optional do if let
                    print(jsonResult)
                }catch{
                    print(error);
                }
                
                
            }
            
        }
        
        task.resume()

    }
    
    func DLImage(){
        let url = NSURL(string:"https://pixabay.com/static/uploads/photo/2015/10/01/21/39/background-image-967820_960_720.jpg")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){(data, response, error) -> Void in
            
            if error != nil{
                print(error)
            } else{
                
                //Save image offline
                var documentsDirectory:String?
                
                var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                
                if(paths.count > 0){
                    documentsDirectory = paths[0] as? String
                    
                    let savePath = documentsDirectory! + "/bach.jpg"
                    
                    NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                    
                    
                    //set function to main thread, not background thread
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        
                        self.image.image = UIImage(named: savePath)
                        
                    })
                    
                }
                
            }
        }
        task.resume()
    }
    
    func coreData(){
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //the databse
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        //        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        //
        //        newUser.setValue("Sally", forKey: "username")
        //        newUser.setValue("PSally", forKey: "password")
        //
        //        do{
        //            try context.save()
        //        } catch{
        //            print("err")
        //        }
        //
        //statement to get data
        var request = NSFetchRequest(entityName: "Users")
        
        //searching
        request.predicate = NSPredicate(format: "username= %@", "Sally")
        request.returnsObjectsAsFaults = false
        //execute statement
        
        do{
            let results = try context.executeFetchRequest(request)
            
            if(results.count > 0){
                for result in results as! [NSManagedObject]{
                    //update data
                    //                    results.setValue("Tom", forKey: "username")
                    //save
                    
                    //Delete object
                    //                    context.deletedObjects(result)
                    //
                    
                    //need to change NSManagedObject to String
                    if let username = result.valueForKey("username") as? String{
                        print (username)
                    }
                }
            }
            
        } catch{
            print("Fetch failed")
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

