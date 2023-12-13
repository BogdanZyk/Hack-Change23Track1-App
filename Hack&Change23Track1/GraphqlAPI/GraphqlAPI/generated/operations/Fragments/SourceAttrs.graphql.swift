// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

struct SourceAttrs: SchemaAPI.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment SourceAttrs on PlaylistSource { __typename Name Id Cover Index }"#
  }

  let __data: DataDict
  init(_dataDict: DataDict) { __data = _dataDict }

  static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PlaylistSource }
  static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("Name", String?.self),
    .field("Id", String?.self),
    .field("Cover", String?.self),
    .field("Index", Int?.self),
  ] }

  var name: String? { __data["Name"] }
  var id: String? { __data["Id"] }
  var cover: String? { __data["Cover"] }
  var index: Int? { __data["Index"] }

  init(
    name: String? = nil,
    id: String? = nil,
    cover: String? = nil,
    index: Int? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.PlaylistSource.typename,
        "Name": name,
        "Id": id,
        "Cover": cover,
        "Index": index,
      ],
      fulfilledFragments: [
        ObjectIdentifier(SourceAttrs.self)
      ]
    ))
  }
}
