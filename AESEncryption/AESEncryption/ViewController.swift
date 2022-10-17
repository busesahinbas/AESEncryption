//
//  ViewController.swift
//  AESEncryption
//
//  Created by Buse Şahinbaş on 14.10.2022.
//

import UIKit
import AESFramework

class ViewController: UIViewController {

    @IBOutlet weak var keyText: UITextField!
    @IBOutlet weak var ivText: UITextField!
    @IBOutlet weak var plainText: UITextField!
    @IBOutlet weak var encryptedText: UITextField!
    @IBOutlet weak var resultEncrypt: UILabel!
    @IBOutlet weak var resultDecrypt: UILabel!
    @IBOutlet weak var resultDecode: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func encryptButton(_ sender: Any) {
        if (keyText.text != nil && ivText.text != nil) {
            if(plainText.text != nil) {
                do {
                    
                    let dataKey = Data(keyText.text!.utf8)
                    let dataIV = Data(ivText.text!.utf8)
                    let aes = try AES256(key: dataKey, iv: dataIV)
                    let digest = plainText.text!.data(using: .utf8)!
                    let encrypted = try aes.encrypt(digest)
                    resultEncrypt.text = encrypted.base64EncodedString()
                    print("String encrypted (base64):\t\(encrypted.base64EncodedString())")
                    
                } catch {
                    print("error")
                }
            }
            
        }else{
            print("key or text cant be empty")
        }
    }
    
    @IBAction func decryptButton(_ sender: Any) {
        if (keyText.text != nil && ivText.text != nil) {
            if(encryptedText.text != nil) {
                do {
                    
                    let dataKey = Data(keyText.text!.utf8)
                    let dataIV = Data(ivText.text!.utf8)
                    let aes = try AES256(key: dataKey, iv: dataIV)

                    let encrypted = encryptedText.text!
                    let data = Data(base64Encoded: encrypted, options: .ignoreUnknownCharacters)!
                    let decrypted = try aes.decrypt(data)
                    print (decrypted.base64EncodedString())
                    resultDecrypt.text = decrypted.base64EncodedString()
                    
                    //let str = String(decoding: decrypted, as: UTF8.self)
                    //resultDecrypt.text = str
                    //print("Decrypted: \(str)")

               
                } catch {
                    print("error")
                }
            }
        }else{
            print("key or text cant be empty")
        }
        
    }
    
    @IBAction func decodeButton(_ sender: Any) {
    
        if(resultDecrypt.text != nil){
            resultDecode.text = resultDecrypt.text?.base64Decoded()
        }
    
    }

}

extension String {
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }

    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

 








