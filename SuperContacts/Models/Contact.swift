//
//  Contact.swift
//  SuperContacts
//
//  Created by Morgan on 15/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class Contact: Object {

    @objc dynamic var ID:String?
    
    @objc dynamic var gender:String?
    @objc dynamic var title:String?
    @objc dynamic var firstname:String?
    @objc dynamic var lastname:String?
    
    @objc dynamic var street:String?
    @objc dynamic var city:String?
    @objc dynamic var state:String?
    @objc dynamic var zip:String?
    
    @objc dynamic var email:String?
    @objc dynamic var username:String?
    @objc dynamic var password:String?
    @objc dynamic var phone:String?
    @objc dynamic var cell:String?
    @objc dynamic var ssn:String?
    
    @objc dynamic var thumbnailData:Data?
    private var _thumbnail:UIImage?
    var thumbnail:UIImage? {
        get {
            return _thumbnail
        }
        set {
            _thumbnail = newValue
            
            let realm = try! Realm()
            
            try! realm.write {
                if (newValue != nil) {
                    self.thumbnailData = newValue!.pngData()
                }
            }
        }
    }
    
    convenience init(dict:(String, JSON)) {
        self.init()
        
        self.ID = "\(NSDate().timeIntervalSince1970)"
//        self.gender = dict[APIResult.GenderKey]
        
    }
    
    convenience init(json:JSON) {
        self.init()
        
        self.ID = "\(NSDate().timeIntervalSince1970)"
        self.gender = json[APIResult.GenderKey].stringValue
        
    }
}
