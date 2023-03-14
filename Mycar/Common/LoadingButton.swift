//
//  LoadingButton.swift
//  Mycar
//
//  Created by Roberto Filho on 07/03/23.
//

import SwiftUI

struct LoadingButton: View {
    
    var action: () -> Void
    var text: String
    var showProgress: Bool = true
    var disabled: Bool = false
    
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }, label: {
                Text(showProgress ? " " : text)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .font(Font.system(.title3).bold())
                    .background(disabled ? Color("lightOrange") : Color.orange)
                    .foregroundColor(Color(.white))
                    .cornerRadius(4.0)
            })
            .disabled(disabled || showProgress)
            
            ProgressView()
              .progressViewStyle(CircularProgressViewStyle())
              .opacity(showProgress ? 1 : 0)
        }
    }
}

struct LoadingButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButton(action: {
            print("Ola mundo")
        }, text: "Cadastrar", showProgress: true, disabled: true)
    }
}
