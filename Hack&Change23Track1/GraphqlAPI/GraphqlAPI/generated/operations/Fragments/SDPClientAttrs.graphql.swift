// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import Hack&Change23Track1

struct SDPClientAttrs: SchemaAPI.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment SDPClientAttrs on ClientSDP { __typename Sdp Type }"#
  }

  let __data: DataDict
  init(_dataDict: DataDict) { __data = _dataDict }

  static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.ClientSDP }
  static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("Sdp", String.self),
    .field("Type", String.self),
  ] }

  var sdp: String { __data["Sdp"] }
  var type: String { __data["Type"] }

  init(
    sdp: String,
    type: String
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.ClientSDP.typename,
        "Sdp": sdp,
        "Type": type,
      ],
      fulfilledFragments: [
        ObjectIdentifier(SDPClientAttrs.self)
      ]
    ))
  }
}
