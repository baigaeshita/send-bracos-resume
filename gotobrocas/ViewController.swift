//
//  ViewController.swift
//  gotobrocas
//
//  Created by Natata on 2016/6/28.
//  Copyright © 2016年 Natata. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let brocasResumeURL = "https://qzqmgdxcm5.execute-api.ap-northeast-1.amazonaws.com/dev/inboxapi"
    
    @IBOutlet weak var job: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var resume: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(sendResume))
    }

    func sendResume(sender: UIBarButtonItem) {
        if !isEmpty(job.text) &&
            !isEmpty(name.text) &&
            isValidPhone(phone.text) &&
            isValidEmail(email.text) &&
            isValidResume(resume.text) {
            
            let parameters = [
                "job": job.text!,
                "name": name.text!,
                "phone": phone.text!,
                "email": email.text!,
                "resume": resume.text!
            ]
            
            Alamofire.request(.POST, brocasResumeURL, parameters: parameters, encoding: .JSON)
                .responseJSON{ response in
                    
                    switch response.result {
                    case .Success:
                        if response.result.value != nil {
                            self.showDialog("SUCCESS", message: "we recieve your resume")
                        }
                    case .Failure(let error):
                        self.showDialog("Fail to send request", message: error.localizedDescription)
                    }
                }
        } else {
            showDialog("Something wrong", message: "Don't leave empty")
        }
    }
    
    func isEmpty(text: String?) -> Bool {
        if text == nil || text == "" {
            return true
        }
        return false
    }
    
    func isValidPhone(phone: String?) -> Bool {
        
        // TODO: check phone format
        
        if isEmpty(phone) {
            return false
        }
        return true
    }
    
    func isValidEmail(email: String?) -> Bool {
        
        // TODO: check email format
        
        if isEmpty(email) {
            return false
        }
        return true
    }
    
    func isValidResume(resume: String?) -> Bool {
        
        // TODO: check url format
        
        if isEmpty(resume) {
            return false
        }
        return true
    }

    func showDialog(title: String, message: String) {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        dialog.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(dialog, animated: true, completion: nil)
    }
}

