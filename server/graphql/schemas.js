var GraphQLSchema = require('graphql').GraphQLSchema;
var GraphQLObjectType = require('graphql').GraphQLObjectType;
var GraphQLList = require('graphql').GraphQLList;
var GraphQLObjectType = require('graphql').GraphQLObjectType;
var GraphQLNonNull = require('graphql').GraphQLNonNull;
var GraphQlInputObjectType = require('graphql').GraphQLInputObjectType;
var GraphQLID = require('graphql').GraphQLID;
var GraphQLString = require('graphql').GraphQLString;
var GraphQLInt = require('graphql').GraphQLInt;
const { GraphQLFloat } = require('graphql');
var GraphQLDate = require('graphql-date');
var {ItemModel} = require('../models/Item');
var {qrModel} = require('../models/QRCode');
var {UserModel} = require('../models/User');

var userType = new GraphQLObjectType({
    // link position[] scale
    name: 'user',
    fields: () => ({
            _id: {
                type: GraphQLString
            },
            name: {
                type: GraphQLString
            },
            email: {
                type: GraphQLString
            },
            password: {
                type: GraphQLString
            }
    }),
});

var itemType = new GraphQLObjectType({
    // link position[] scale
    name: 'item',
    fields: () => ({
            _id: {
                type: GraphQLString
            },
            name: {
                type: GraphQLString
            },
            Price: {
                type: GraphQLFloat
            },
            picture: {
                type: GraphQLString
            },
            stock: {
                type: GraphQLList(GraphQLInt)
            },
            desc: {
                type: GraphQLString
            },
            color: {
                type: GraphQLString
            }
    }),
});

var qrType = new GraphQLObjectType({
    // link position[] scale
    name: 'qr',
    fields: () => ({
            _id: {
                type: GraphQLString
            },
            value: {
                type: GraphQLString
            }
    }),
});


var queryType = new GraphQLObjectType({
    name: 'Query',
    fields: function () {
        return {
            user: {
                type: userType,
                args: {
                    id: {
                        name: '_id',
                        type: GraphQLString
                    }
                },
                resolve: function (root, params) {
                    const userDetails = UserModel.findById(params.id).exec()
                    if (!userDetails) {
                        throw new Error('Error')
                    }
                    return userDetails
                }
            },

            getItemById: {
                type: itemType,
                args: {
                    id: {
                        name: '_id',
                        type: GraphQLString
                    }
                },
                resolve: function (root, params) {
                    const itemDetails = ItemModel.findById(params.id).exec()
                    if (!itemDetails) {
                        throw new Error('Error')
                    }
                    return itemDetails
                }
            },
            getItemsByName: {
                type: new GraphQLList(itemType),
                args: {
                    name: {
                        name: 'name',
                        type: GraphQLString
                    }
                },
                resolve: function (root, params) {
                    const itemDetails = ItemModel.find({name: params.name}).exec()
                    if (!itemDetails) {
                        throw new Error('Error')
                    }
                    return itemDetails
                }
            },

            qr: {
                type: qrType,
                args: {
                    id: {
                        name: '_id',
                        type: GraphQLString
                    }
                },
                resolve: function (root, params) {
                    const qrDetails = qrModel.findById(params.id).exec()
                    if (!itemDetails) {
                        throw new Error('Error')
                    }
                    return qrDetails
                }
            },

        }
    }
});

var mutation = new GraphQLObjectType({
    name: 'Mutation',
    fields: function () {
        return {
            addUser: {
                type: userType,
                args: {
                    name: {
                        type: new GraphQLNonNull(GraphQLString)
                    },
                    email: {
                        type: new GraphQLNonNull(GraphQLString)
                    },
                    password: {
                        type: new GraphQLNonNull(GraphQLString)
                    }
                },
                resolve: function (root, params) {
                    const userModel = new UserModel(params);
                    const newUser = userModel.save();
                    if (!newUser) {
                        throw new Error('Error');
                    }
                    return newUser
                }
            },

            addItem: {
                type: itemType,
                args: {
                    name: {
                        type: new GraphQLNonNull(GraphQLString)
                    },
                    price: {
                        type: new GraphQLNonNull(GraphQLFloat)
                    },
                    picture: {
                        type: new GraphQLNonNull(GraphQLString)
                    },
                    stock: {
                        type: new GraphQLNonNull(GraphQLList(GraphQLInt))
                    },
                    desc: {
                        type: new GraphQLNonNull(GraphQLString)
                    },
                    color: {
                        type: new GraphQLNonNull(GraphQLString)
                    }
                },
                resolve: function (root, params) {
                    const itemModel = new ItemModel(params);
                    const newItem = itemModel.save();
                    if (!newItem) {
                        throw new Error('Error');
                    }
                    return newItem
                }
            },

            addQR: {
                type: qrType,
                args: {
                    value: {
                        type: new GraphQLNonNull(GraphQLString)
                    }
                },
                resolve: function (root, params) {
                    const QRModel = new qrModel(params);
                    const qrUser = QRModel.save();
                    if (!qrUser) {
                        throw new Error('Error');
                    }
                    return qrUser
                }
            },

        }
    }
});

module.exports = new GraphQLSchema({ query: queryType, mutation: mutation });