// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class SignUpMutation: GraphQLMutation {
  static let operationName: String = "SignUp"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SignUp($login: String!, $password: String!) { SignUp(Login: $login, Password: $password) { __typename Token } }"#
    ))

  public var login: String
  public var password: String

  public init(
    login: String,
    password: String
  ) {
    self.login = login
    self.password = password
  }

  public var __variables: Variables? { [
    "login": login,
    "password": password
  ] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("SignUp", SignUp?.self, arguments: [
        "Login": .variable("login"),
        "Password": .variable("password")
      ]),
    ] }

    var signUp: SignUp? { __data["SignUp"] }

    init(
      signUp: SignUp? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "SignUp": signUp._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(SignUpMutation.Data.self)
        ]
      ))
    }

    /// SignUp
    ///
    /// Parent Type: `Token`
    struct SignUp: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Token }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("Token", String.self),
      ] }

      var token: String { __data["Token"] }

      init(
        token: String
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.Token.typename,
            "Token": token,
          ],
          fulfilledFragments: [
            ObjectIdentifier(SignUpMutation.Data.SignUp.self)
          ]
        ))
      }
    }
  }
}
