// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct SourceAttrs: SchemaAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment SourceAttrs on Source { __typename Id Cover Name }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("Id", String.self),
    .field("Cover", String.self),
    .field("Name", String.self),
  ] }

  public var id: String { __data["Id"] }
  public var cover: String { __data["Cover"] }
  public var name: String { __data["Name"] }

  public init(
    id: String,
    cover: String,
    name: String
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.Source.typename,
        "Id": id,
        "Cover": cover,
        "Name": name,
      ],
      fulfilledFragments: [
        ObjectIdentifier(SourceAttrs.self)
      ]
    ))
  }
}
