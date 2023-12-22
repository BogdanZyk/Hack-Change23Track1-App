// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct ReplyMessageAttrs: SchemaAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment ReplyMessageAttrs on ReplyMessage { __typename Id Text UserName }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.ReplyMessage }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("Id", String?.self),
    .field("Text", String?.self),
    .field("UserName", String?.self),
  ] }

  public var id: String? { __data["Id"] }
  public var text: String? { __data["Text"] }
  public var userName: String? { __data["UserName"] }

  public init(
    id: String? = nil,
    text: String? = nil,
    userName: String? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.ReplyMessage.typename,
        "Id": id,
        "Text": text,
        "UserName": userName,
      ],
      fulfilledFragments: [
        ObjectIdentifier(ReplyMessageAttrs.self)
      ]
    ))
  }
}
