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
import BadasSwift

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
    
    @objc dynamic var pictureLarge:String?
    @objc dynamic var pictureMedium:String?
    @objc dynamic var pictureThumbnail:String?
    
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
    
    convenience init(json:JSON) {
        self.init()
        
        self.ID = "\(NSDate().timeIntervalSince1970)"
        
        self.username = json[APIResult.UsernameKey].stringValue
        self.email = json[APIResult.EmailKey].stringValue
        self.password = json[APIResult.PasswordKey].stringValue
        
        self.phone = json[APIResult.PhoneKey].stringValue
        self.cell = json[APIResult.CellKey].stringValue
        self.ssn = json[APIResult.SSNKey].stringValue
        
        self.gender = json[APIResult.GenderKey].stringValue
        
        let name = json[APIResult.NameKey]
        
        self.title = name[APIResult.TitleKey].stringValue
        self.firstname = name[APIResult.FirstnameKey].stringValue
        self.lastname = name[APIResult.LastNameKey].stringValue
        
        let loc = json[APIResult.LocationKey]
        
        self.street = loc[APIResult.StreetKey].stringValue
        self.city = loc[APIResult.CityKey].stringValue
        self.state = loc[APIResult.StateKey].stringValue
        self.zip = loc[APIResult.ZipKey].stringValue
        
        // Works with APIResult.MediumPicture & .LargePicture
        let img = json[APIResult.PictureKey]
    
        pictureLarge = img[APIResult.LargePictureKey].stringValue
        pictureMedium = img[APIResult.MediumPictureKey].stringValue
        pictureThumbnail = img[APIResult.ThumbnailPictureKey].stringValue
        
        UIImage.getImageWithURL(URL(string: pictureThumbnail!)!, completion: { (img) in
            self.thumbnail = img
        })
    }
    
    func toString() -> String {
        let res = "ID : \(String(describing: ID!))\n" +
                "Username \(String(describing: username))" +
                "Email \(String(describing: email))" +
                "Password \(String(describing: password))" +
                "Gender: \(String(describing: gender!))\n" +
                "Title: \(String(describing: title!))\n" +
                "Name: \(String(describing: firstname!)) \(String(describing: lastname!))\n" +
                "Phone \(String(describing: phone))" +
                "Adress: \(String(describing: street!)) \(String(describing: city!)) \(String(describing: state!)) \(String(describing: zip!))"
        return res
    }
}
