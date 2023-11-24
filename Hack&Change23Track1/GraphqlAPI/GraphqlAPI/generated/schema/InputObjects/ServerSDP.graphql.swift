// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension SchemaAPI {
  struct ServerSDP: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      sdp: GraphQLNullable<String> = nil,
      type: GraphQLNullable<String> = nil
    ) {
      __data = InputDict([
        "Sdp": sdp,
        "Type": type
      ])
    }

    public var sdp: GraphQLNullable<String> {
      get { __data["Sdp"] }
      set { __data["Sdp"] = newValue }
    }

    public var type: GraphQLNullable<String> {
      get { __data["Type"] }
      set { __data["Type"] = newValue }
    }
  }

}