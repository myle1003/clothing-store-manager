//
//  SignUpViewModel.swift
//  H3MShop
//
//  Created by Van Huy on 24/10/2022.
//

import Foundation

enum FailureSignUp: String{
    
    case emptyField = "✖︎ Please fill all the field"
    case wrongField = "✖︎ You fill wrong field"
    case wrong = "✖︎"
    case none = ""
}

enum SucessLogin: String{
    case valids =  "✔︎"
}



class SignUpViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    @Published var password2 = ""
    
    @Published var isCheck = false
    @Published var isFocusEmail = false
    @Published var isValidEmail = false
    @Published var isFocusUserName = false
    @Published var isValidUserName = false
    @Published var isFocusPassword = false
    @Published var isValidPassword = false
    @Published var isFocusCofirmPassword = false
    @Published var isCofirmPassword = false
    @Published var isEmptyField = false
    @Published var isRightAllField = true
    @Published var isSuccessSignUp = false
    
    @Published var response: LoginResponse =  LoginResponse()
    
    
    func register() async throws -> LoginResponse {
        
        let urlString = Constants.baseURL + Endpoints.register
        
        guard let url = URL(string: urlString) else {
            throw httpError.badURL
        }
        
        let registerRequest = RegisterRequest(name: name,
                                        email: email,
                                        password: password,
                                        password2: password2)
        return try await HttpClient.shared.checkLoginAPI(to: url,
                                                         object: registerRequest,
                                                         httpMethod: httpMethod.POST.rawValue)
    }
    
    
    //MARK: Validate email address logic
    func isValidEmails() -> Bool {
        if email.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    //MARK: - UserName Validation
    //==========================
    func isValidUsername() -> Bool {
        let RegEx = "\\A\\w{4,12}\\z"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: name)
    }
    
    //MARK:    length 8 to 16.
    //MARK:    One Alphabet in Password.
    //MARK:    One Special Character in Password.
    func isValidPassWord() -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,16}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: password)
        return result
    }
    
    //MARK: Check Password Confirm
    func checkPasswordConfirm() -> Bool {
        return password == password2
    }
    
    func isEmptyFields() -> Bool {
        if (email == "") || (name == "") || (password == "") || (password2 == "") {
            return true
        }
        return false
    }
    
    func isRightAllFields() -> Bool {
        if isValidEmails() && isValidUsername() && isValidPassWord() && checkPasswordConfirm() {
            return true
        }
        return false
    }
    
    
}
