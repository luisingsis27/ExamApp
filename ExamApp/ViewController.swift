//
//  ViewController.swift
//  ExamApp
//
//  Created by Luis on 16/03/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var btnPhoto: UIButton!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNombre.delegate = self
            
    }

    @IBAction func takePicture(_ sender: Any) {

        
        let alert = UIAlertController(title: "Selecciona una opcion", message:nil ,preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Tomar foto", style: .default , handler:{ (UIAlertAction)in
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                           let imagePicker = UIImagePickerController()
                           imagePicker.delegate = self
                           imagePicker.sourceType = UIImagePickerController.SourceType.camera
                           imagePicker.allowsEditing = false
                           self.present(imagePicker, animated: true, completion: nil)
                       }
            }))
            
            alert.addAction(UIAlertAction(title: "Galeria", style: .default , handler:{ (UIAlertAction)in
                let image = UIImagePickerController()
                image.delegate = self
                image.sourceType = UIImagePickerController.SourceType.photoLibrary
                image.allowsEditing = false
                
                self.present(image, animated: true)
                {
                    
                }
            }))

            alert.popoverPresentationController?.sourceView = self.view
            self.present(alert, animated: true, completion: {
            })
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imgPhoto.contentMode = .scaleToFill
            imgPhoto.image = image
            
        }
        else{
            
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
  
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxyz").inverted
        
        let components = string.components(separatedBy: allowedCharacters)
            let filtered = components.joined(separator: "")
            
            if string == filtered {
                
                return true

            } else {
                
                return false
            }
    }
    
    @IBAction func txtNombreChanged(_ sender: Any)
    {
        
    }
    
    
    
    @IBAction func btnMostrarGraficas(_ sender: Any) {
        
    }
}
