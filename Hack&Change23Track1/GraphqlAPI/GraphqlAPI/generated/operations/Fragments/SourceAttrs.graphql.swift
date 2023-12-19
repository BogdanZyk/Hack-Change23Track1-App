// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

struct SourceAttrs: SchemaAPI.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment SourceAttrs on Source { __typename Id Cover Name }"#
  }

  let __data: DataDict
  init(_dataDict: DataDict) { __data = _dataDict }

  static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }
  static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("Id", String.self),
    .field("Cover", String.self),
    .field("Name", String.self),
  ] }

  var id: String { __data["Id"] }
  var cover: String { __data["Cover"] }
  var name: String { __data["Name"] }

  init(
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
