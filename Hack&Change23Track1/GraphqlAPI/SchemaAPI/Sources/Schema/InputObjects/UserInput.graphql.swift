// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct UserInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    id: String,
    email: String,
    login: String,
    avatar: String
  ) {
    __data = InputDict([
      "Id": id,
      "Email": email,
      "Login": login,
      "Avatar": avatar
    ])
  }

  public var id: String {
    get { __data["Id"] }
    set { __data["Id"] = newValue }
  }

  public var email: String {
    get { __data["Email"] }
    set { __data["Email"] = newValue }
  }

  public var login: String {
    get { __data["Login"] }
    set { __data["Login"] = newValue }
  }

  public var avatar: String {
    get { __data["Avatar"] }
    set { __data["Avatar"] = newValue }
  }
}
