// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

struct SourceAttrs: SchemaAPI.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment SourceAttrs on Source { __typename Name Id Cover }"#
  }

  let __data: DataDict
  init(_dataDict: DataDict) { __data = _dataDict }

  static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }
  static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("Name", String?.self),
    .field("Id", String?.self),
    .field("Cover", String?.self),
  ] }

  var name: String? { __data["Name"] }
  var id: String? { __data["Id"] }
  var cover: String? { __data["Cover"] }

  init(
    name: String? = nil,
    id: String? = nil,
    cover: String? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.Source.typename,
        "Name": name,
        "Id": id,
        "Cover": cover,
      ],
      fulfilledFragments: [
        ObjectIdentifier(SourceAttrs.self)
      ]
    ))
  }
}
