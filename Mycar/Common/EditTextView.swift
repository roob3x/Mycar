//
//  EditTextView.swift
//  Mycar
//
//  Created by Roberto Filho on 07/03/23.
//

import SwiftUI

struct EditTextView: View {
    
    @Binding var text: String
    var placeholder: String = ""
    var keyboard: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? =  nil
    var autocapitalization: UITextAutocapitalizationType = .none

    
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .foregroundColor(Color(.black))
                .keyboardType(keyboard)
                .autocapitalization(autocapitalization)
                .textFieldStyle(CustomTextFieldStyle())
            
            if let error = error, failure == true, !text.isEmpty {
                Text(error).foregroundColor(.red)
            }
        }
            
    }
}

struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        EditTextView(text: .constant("Robertinho"))
    }
}
