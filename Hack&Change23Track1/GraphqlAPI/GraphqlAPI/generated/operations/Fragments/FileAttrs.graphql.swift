// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

struct FileAttrs: SchemaAPI.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment FileAttrs on Audio { __typename Id Name }"#
  }

  let __data: DataDict
  init(_dataDict: DataDict) { __data = _dataDict }

  static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Audio }
  static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("Id", String?.self),
    .field("Name", String?.self),
  ] }

  var id: String? { __data["Id"] }
  var name: String? { __data["Name"] }

  init(
    id: String? = nil,
    name: String? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.Audio.typename,
        "Id": id,
        "Name": name,
      ],
      fulfilledFragments: [
        ObjectIdentifier(FileAttrs.self)
      ]
    ))
  }
}
