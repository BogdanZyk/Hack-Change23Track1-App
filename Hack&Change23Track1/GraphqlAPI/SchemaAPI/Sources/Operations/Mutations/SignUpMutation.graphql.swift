// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SignUpMutation: GraphQLMutation {
  public static let operationName: String = "SignUp"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SignUp($login: String!, $password: String!, $email: String!) { SignUp(Login: $login, Password: $password, Email: $email) { __typename Token } }"#
    ))

  public var login: String
  public var password: String
  public var email: String

  public init(
    login: String,
    password: String,
    email: String
  ) {
    self.login = login
    self.password = password
    self.email = email
  }

  public var __variables: Variables? { [
    "login": login,
    "password": password,
    "email": email
  ] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("SignUp", SignUp?.self, arguments: [
        "Login": .variable("login"),
        "Password": .variable("password"),
        "Email": .variable("email")
      ]),
    ] }

    public var signUp: SignUp? { __data["SignUp"] }

    public init(
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
    public struct SignUp: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Token }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("Token", String.self),
      ] }

      public var token: String { __data["Token"] }

      public init(
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
