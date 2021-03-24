//
//  ViewController.swift
//  Get_trial_6_Tableview_marvel
//
//  Created by iroid on 24/03/21.
//  Copyright © 2021 iroid. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var Mytable: UITableView!
    
    var namearray = [""]
    var realnamearray = [""]
    var creatorarray = [""]
    var bioarray = [""]
    var teamArray = [""]
    var publisherarray = [""]
    var appearancearray = [""]
    var imagearray = [""]
    
    let getdata = NSMutableData()
    var jsondata = NSArray()
    var jsondict = NSDictionary()
    
    override func viewWillAppear(_ animated: Bool) {
        let jsonurl = URL(string:"https://www.simplifiedcoding.net/demos/marvel/")
        let Request = URLRequest(url: jsonurl!)
        
        let task = URLSession.shared.dataTask(with: Request){(data,request,error) in
            
            if let mydata = data {
                
                print("mydata>>",mydata)
                
                do {
                    self.jsondata = try JSONSerialization.jsonObject(with: mydata, options: []) as! NSArray
                    DispatchQueue.main.async {
                        for i in 0..<self.jsondata.count{
                            self.jsondict = self.jsondata[i] as! NSDictionary
                            self.namearray.append(self.jsondict["name"]! as! String)
                            self.realnamearray.append(self.jsondict["realname"]! as! String)
                            self.teamArray.append(self.jsondict["team"]! as! String)
                            self.appearancearray.append(self.jsondict["firstappearance"]! as! String)
                            self.creatorarray.append(self.jsondict["createdby"]! as! String)
                            self.publisherarray.append(self.jsondict["publisher"]! as! String)
                            self.bioarray.append(self.jsondict["bio"]! as! String)
                            self.imagearray.append(self.jsondict["imageurl"]! as! String)
                        }
                        self.namearray.remove(at: 0)
                        self.realnamearray.remove(at: 0)
                        self.teamArray.remove(at: 0)
                        self.appearancearray.remove(at: 0)
                        self.creatorarray.remove(at: 0)
                        self.publisherarray.remove(at: 0)
                        self.bioarray.remove(at: 0)
                        self.imagearray.remove(at: 0)
                        self.Mytable.reloadData()
                    
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
                }
                
            }
            task.resume()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsondata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tcell = tableView.dequeueReusableCell(withIdentifier: "Marvel", for: indexPath) as! MarvelTableViewCell
        
        tcell.NameTxt.text = namearray[indexPath.row]
        tcell.realNametxt.text = realnamearray[indexPath.row]
        tcell.teamtxt.text = teamArray[indexPath.row]
        tcell.appeartxt.text = appearancearray[indexPath.row]
        tcell.creatortxt.text = creatorarray[indexPath.row]
        tcell.bioTextvieetxt.text = bioarray[indexPath.row]
        
        let imageurl=URL(string:String(self.imagearray[indexPath.row]))
        let imagedata = try? Data(contentsOf:imageurl!)
        tcell.imagevw.image = UIImage(data:imagedata!)
        
        return tcell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
        
        
    }
    

    
}

