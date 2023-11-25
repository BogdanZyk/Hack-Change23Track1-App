// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class SignInMutation: GraphQLMutation {
  static let operationName: String = "SignIn"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SignIn($email: String!, $password: String!) { SignIn(Email: $email, Password: $password) { __typename Token } }"#
    ))

  public var email: String
  public var password: String

  public init(
    email: String,
    password: String
  ) {
    self.email = email
    self.password = password
  }

  public var __variables: Variables? { [
    "email": email,
    "password": password
  ] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("SignIn", SignIn?.self, arguments: [
        "Email": .variable("email"),
        "Password": .variable("password")
      ]),
    ] }

    var signIn: SignIn? { __data["SignIn"] }

    init(
      signIn: SignIn? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "SignIn": signIn._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(SignInMutation.Data.self)
        ]
      ))
    }

    /// SignIn
    ///
    /// Parent Type: `Token`
    struct SignIn: SchemaAPI.SelectionSet {
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
            ObjectIdentifier(SignInMutation.Data.SignIn.self)
          ]
        ))
      }
    }
  }
}
